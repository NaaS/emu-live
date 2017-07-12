/*
LRU cache
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using KiwiSystem;

public class Data {
  public bool matched = false;
  public ulong result = 0;
}

public class LRU
{
   public static Data Lookup(ulong key_in)
   {
     Data res = new Data();
     ulong idx = 0;

     idx = HashCAM.Read(key_in);

     res.matched = HashCAM.matched;
     res.result = 0;

     if (HashCAM.matched) {
       NaughtyQ.BackOfQ(idx);
       res.result = NaughtyQ.Read(idx);
     }

     return res;
   }

   public static void Cache(ulong key_in, ulong value_in)
   {
     // FIXME could delete node (move it to front of queue)
     //       if it already exists in the queue.
     //       That would avoid "bubbles" of unnecessary
     //       nodes forming in the queue.
     ulong idx = NaughtyQ.Enlist(value_in);
     HashCAM.Write(key_in, idx);
     // FIXME relay "is_full"
   }

   // TODO deleting entries from the cache.

   [Kiwi.HardwareEntryPoint()]
   static void Main()
     Data result;
     result = LRU.Lookup(13);

     LRU.Cache(13, 2);
     LRU.Cache(13, 20);

     LRU.Lookup(13);
     LRU.Lookup(13);
   }
}
