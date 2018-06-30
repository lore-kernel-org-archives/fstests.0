Received: from mail.paulo.ac ([34.238.86.106]:38032 "EHLO mail.paulo.ac"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbeF3Sup (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 30 Jun 2018 14:50:45 -0400
From: Paulo Alcantara <paulo@paulo.ac>
Subject: Re: [PATCH 2/2] cifs: Handle OFD locks
In-Reply-To: <20180630040544.GX2780@desktop>
References: <20180629205500.7950-1-paulo@paulo.ac> <20180629205500.7950-2-paulo@paulo.ac> <CAH2r5msCUKvDsC51ABrnssmkvp=Tcj9cfP4U-spm+S=w-__huw@mail.gmail.com> <20180630040544.GX2780@desktop>
Date: Sat, 30 Jun 2018 15:42:22 -0300
Message-ID: <87tvpkm7zl.fsf@paulo.ac>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Eryu Guan <guaneryu@gmail.com> writes:

> On Fri, Jun 29, 2018 at 06:41:40PM -0500, Steve French wrote:
>> Paulo,
>> Did you find out if there were any xfstests for OFD locks, or whether
>> you could add
>> one of yours or Jeff's to xfstests for this?

Nope. I didn't know there was a xfstest for that. I just performed my
own quick tests (based on Jeff's) to test the POSIX and OFD locks after
the changes.

> generic/478 is an OFD lock test, but I'm not sure if the CIFS bug could
> be covered by it. Good to have new tests if not already covered :)

Cool! I'll give it a try and see whether it can be covered by the CIFS
bug. Otherwise, I'll make sure to add new test cases to it (if time
allows).

Thanks guys!

     Paulo
