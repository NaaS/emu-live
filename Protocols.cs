/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using KiwiSystem;

namespace Emu
{
  namespace Protocols
  {
    public static class Ethernet
    {
       public enum EtherTypes { IPv4 = 0x0008 };

       public static ulong Destination_MAC(this ulong[] frame)
       {
          return frame.Extract_Bytes(length: 6);
       }

       public static ulong Source_MAC(this ulong[] frame)
       {
          return frame.Extract_Bytes(from_byte: 6, length: 6);
       }

       public static ulong EtherType(this ulong[] frame)
       {
          return frame.Extract_Bytes(from_byte: 12, length: 2);
       }

       public static bool EtherType_Is(this ulong[] frame, EtherTypes et)
       {
          return(EtherType(frame) == (ulong)et);
       }
    }

    public static class IPv4
    {
       // This procedure perform the calculation of the new checksum and verification
       // It returns the new checksum(on calculation process) or 0x00 if no-errors were detected(on verification process)
       public static ulong calc_IP_checksum (ulong[] tdata)
       {
          byte  i;
          ulong data    = 0x00, tmp0 = 0x00, tmp1 = 0x00, tmp2 = 0x00, tmp3 = 0x00;
          ulong sum0    = 0x00, sum1 = 0x00, sum = 0x00, sum2 = 0x00, sum3 = 0x00, carry;
          ulong sum_all = 0x00;


          for (i = 1; i <= 4; i++)
          {
             data = (i == 1) ? tdata[1] >> 48 : (i == 4) ? tdata[4] << 48 : (i == 2 || i == 3) ? tdata[i] : (ulong)0x00;
             Kiwi.Pause();
             // extract every 16-bit from the stream for addition and reorder it to big endianess
             tmp0 = ((ulong)(data >> 0) & (ulong)0x00ff) << 8 | ((ulong)(data >> 0) & (ulong)0x00ff00) >> 8;
             tmp1 = ((ulong)(data >> 16) & (ulong)0x00ff) << 8 | ((ulong)(data >> 16) & (ulong)0x00ff00) >> 8;
             tmp2 = ((ulong)(data >> 32) & (ulong)0x00ff) << 8 | ((ulong)(data >> 32) & (ulong)0x00ff00) >> 8;
             tmp3 = ((ulong)(data >> 48) & (ulong)0x00ff) << 8 | ((ulong)(data >> 48) & (ulong)0x00ff00) >> 8;

             // check for carry and add it if its needed
             sum0 = (ulong)((tmp0 + tmp1) & (ulong)0x00ffff) + (ulong)((tmp0 + tmp1) >> 16);
             sum1 = (ulong)((tmp2 + tmp3) & (ulong)0x00ffff) + (ulong)((tmp2 + tmp3) >> 16);
             Kiwi.Pause();
             // check for carry and add it if its needed
             sum = (ulong)((sum0 + sum1) & (ulong)0x00ffff) + (ulong)((sum0 + sum1) >> 16);
             // add the current sum to the previous sums
             sum_all = (ulong)((sum + sum_all) & (ulong)0x00ffff) + (ulong)((sum + sum_all) >> 16);
          }

    //		//(ulong)(~sum0 & (ulong)0x00ffff); DOESNT WORK

          sum_all = (sum_all ^ ~(ulong)0x00) & (ulong)0x00ffff;

          return(sum_all);
       }
    }

    public static class UDP
    {
       // This procedure calculates the checksum of a given byte stream
       // It returns the result in big endianess format
       // It doenst compute the 1's complement
       public static ulong calc_UDP_checksum (ulong current_chksum_UDP, ulong data)
       {
          ulong tmp0 = 0x00, tmp1 = 0x00, tmp2 = 0x00, tmp3 = 0x00, sum0 = 0, sum1 = 0, sum = 0, chk = 0;
          byte  i    = 0;

          chk = current_chksum_UDP;
          // The ICMP header & payload start from this packet number
          if (true)                   //cnt > (uint)3 )
          {
             // extract every 16-bit from the stream for addition and reorder it to big endianess

             tmp0 = ((ulong)(data >> 0) & (ulong)0x00ff) << 8 | ((ulong)(data >> 0) & (ulong)0x00ff00) >> 8;
             tmp1 = ((ulong)(data >> 16) & (ulong)0x00ff) << 8 | ((ulong)(data >> 16) & (ulong)0x00ff00) >> 8;
             tmp2 = ((ulong)(data >> 32) & (ulong)0x00ff) << 8 | ((ulong)(data >> 32) & (ulong)0x00ff00) >> 8;
             tmp3 = ((ulong)(data >> 48) & (ulong)0x00ff) << 8 | ((ulong)(data >> 48) & (ulong)0x00ff00) >> 8;

             // check for carry and add it if its needed
             sum0 = (ulong)((tmp0 + tmp1) & (ulong)0x00ffff) + (ulong)((tmp0 + tmp1) >> 16);
             sum1 = (ulong)((tmp2 + tmp3) & (ulong)0x00ffff) + (ulong)((tmp2 + tmp3) >> 16);
             Kiwi.Pause();
             // check for carry and add it if its needed
             sum = (ulong)((sum0 + sum1) & (ulong)0x00ffff) + (ulong)((sum0 + sum1) >> 16);
             // add the current sum to the previous sums
             current_chksum_UDP = (ulong)((sum + chk) & (ulong)0x00ffff) + (ulong)((sum + chk) >> 16);
          }

          return current_chksum_UDP;
       }
    }
  }
}
