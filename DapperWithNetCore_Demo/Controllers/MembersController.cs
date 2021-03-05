using Dapper;
using DapperWithNetCore_Demo.Models;
using DapperWithNetCore_Demo.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace DapperWithNetCore_Demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MembersController : ControllerBase
    {
        private readonly IDapperRepository _repository;
        public MembersController(IDapperRepository repository)
        {
            _repository = repository;
        }

        [HttpPost(nameof(Create))]
        public async Task<int> Create(Members data)
        {
            var parameters = new DynamicParameters();
            parameters.Add("Id", data.Id, DbType.Int32);
            parameters.Add("Name", data.Name, DbType.String);
            parameters.Add("Address", data.Address, DbType.String);
            parameters.Add("Contact", data.Contact, DbType.String);
            parameters.Add("retVal", DbType.String, direction: ParameterDirection.Output);
            var result = await Task.FromResult(_repository.Execute<int>("[dbo].[sp_AddMember]"
                , parameters,
                commandType: CommandType.StoredProcedure));
            return result;
        }
        [HttpGet(nameof(GetMembers))]
        public async Task<List<Members>> GetMembers()
        {
            var result = await Task.FromResult(_repository.GetAll<Members>($"Select * from [members]", null, commandType: CommandType.Text));
            return result;
        }
        [HttpPost(nameof(Update))]
        public async Task<int> Update(Members data)
        {
            var dp_params = new DynamicParameters();
            dp_params.Add("Id", data.Id, DbType.Int32);
            dp_params.Add("Name", data.Name, DbType.String);
            dp_params.Add("Address", data.Address, DbType.String);
            dp_params.Add("Contact", data.Contact, DbType.String);
            dp_params.Add("retVal", DbType.String, direction: ParameterDirection.Output);
            var result = await Task.FromResult(_repository.Execute<int>("[dbo].[sp_UpdateMember]"
                , dp_params,
                commandType: CommandType.StoredProcedure));
            return result;
        }
        [HttpDelete(nameof(Delete))]
        public async Task<int> Delete(int Id)
        {
            var dp_params = new DynamicParameters();
            dp_params.Add("Id", Id, DbType.Int32);
            dp_params.Add("retVal", DbType.String, direction: ParameterDirection.Output);
            var result = await Task.FromResult(_repository.Execute<int>("[dbo].[sp_DeleteMember]"
                , dp_params,
                commandType: CommandType.StoredProcedure));
            return result;
        }
    }
}
