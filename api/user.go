package api

import (
	db "bank/db/sqlc"
	"bank/util"
	"github.com/gin-gonic/gin"
	"github.com/lib/pq"
	"net/http"
)

type createUserRequest struct {
	Username string `json:"username" binding:"required,alphanum"`
	Password string `json:"password" binding:"required,min=6,max=10"`
	FullName string `json:"full_name" binding:"required,min=5,max=100,alphanum"`
	Email    string `json:"email" binging:"required,email"`
}

func (server *Server) createUser(ctx *gin.Context) {
	var request createUserRequest
	if err := ctx.ShouldBindJSON(&request); err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	hashedPassword, err := util.HashPassword(request.Password)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	arg := db.CreateUserParams{
		Username:       request.Username,
		HashedPassword: hashedPassword,
		Email:          request.Email,
		FullName:       request.FullName,
	}

	account, err := server.store.CreateUser(ctx, arg)
	if err != nil {
		if pqErr, ok := err.(*pq.Error); ok {

			switch pqErr.Code.Name() {
			case "unique_violation":
				ctx.JSON(http.StatusForbidden, errorResponse(err))
				return
			}
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, account)
}
