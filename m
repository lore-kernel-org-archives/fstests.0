Received: from mail-vk0-f46.google.com ([209.85.213.46]:40510 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeDBQOy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Apr 2018 12:14:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5ChFX-92CrNE7fOiTcVWLCxZ9=MQOFHc0WFNdVbUwSQQ@mail.gmail.com>
References: <20180326225921.10096-1-fdmanana@kernel.org> <20180328021753.GE30836@localhost.localdomain>
 <CAL3q7H4FqvoVs69mfWFh1M=8bDZ5FSHcq0KKg+g0C5HcjLuXwg@mail.gmail.com>
 <20180328103358.GG30836@localhost.localdomain> <CAL3q7H7f8gVSitTudAopognpru9LRtoTJfm+8D-N0SYtiWeZpA@mail.gmail.com>
 <CA+EzBbBOZ3vtTPHMXCfU5ONADc1Hn-Ur3OTRpR4Vn+Qwa1u3aA@mail.gmail.com> <CAL3q7H5ChFX-92CrNE7fOiTcVWLCxZ9=MQOFHc0WFNdVbUwSQQ@mail.gmail.com>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Mon, 2 Apr 2018 11:14:53 -0500
Message-ID: <CA+EzBbBTO2rm3vufp-4wjXbkJ2Y82=KrUbuj_rs_q5fc4ZycjA@mail.gmail.com>
Subject: Re: [PATCH] fstests: test btrfs fsync after hole punching with
 no-holes mode
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 2, 2018 at 9:24 AM, Filipe Manana <fdmanana@kernel.org> wrote:
> On Thu, Mar 29, 2018 at 7:55 PM, Jayashree Mohan
> <jayashree2912@gmail.com> wrote:
>> Hi Filipe,
>>
>> I tried running the xfstest above on kernel 4.15.0 and I haven't been
>> able to hit the bug. The xfstest passes clean for me. I compared the
>> btrfs-debug-tree in my case with the one attached by Eryu, and I see I
>> do not have any xattr as he does. However, for every run of the
>> xfstest, the extent tree info that I get from btrfs-debug-tree has
>> varying number of items in the first leaf node. (I have attached two
>> dump files for your reference.)
>>
>> I also tried changing the offset at which fpunch is performed to match
>> the offset of the last extent in the first leaf of the extent tree -
>> however the md5 before and after crash was the same.
>>
>> Could you give more details on this?
>
> You are getting extents smaller then 256Kb, because writeback is being
> triggered by the kernel (likely due to memory pressure).
> The second version of the test uses direct IO instead to avoid that.
> Thanks.

Thanks for the clarification. I am able to reproduce the bug with the
new version of the test that uses direct writes.
