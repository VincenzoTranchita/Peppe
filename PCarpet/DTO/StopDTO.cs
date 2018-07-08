﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PCarpet.DTO
{
    public class StopDTO
    {
        public int id { get; set; }
        public DateTime start { get; set; }
        public DateTime finish { get; set; }
        public string license_plate { get; set; }

        public StopDTO()
        {
        }

        public StopDTO(int id, DateTime start, DateTime finish, string license_plate)
        {
            this.id = id;
            this.start = start;
            this.finish = finish;
            this.license_plate = license_plate;
        }
    }
}