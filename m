Received: from mail.cn.fujitsu.com ([183.91.158.132]:27092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762216AbdLSK7Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Dec 2017 05:59:16 -0500
Message-ID: <5A38F100.5090305@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 18:59:12 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted
 whole-dev
References: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com> <20171204082923.GF2749@eguan.usersys.redhat.com>        <5A251225.7080905@cn.fujitsu.com>       <20171204092558.GH2749@eguan.usersys.redhat.com>        <5A2519F4.5040102@cn.fujitsu.com>       <20171204182953.GA16308@vader.DHCP.thefacebook.com>     <5A38EDAF.5070407@cn.fujitsu.com> <mqd3747at09.fsf@linux-x5ow.site>
In-Reply-To: <mqd3747at09.fsf@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Omar Sandoval <osandov@osandov.com>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/12/19 18:53, Johannes Thumshirn wrote:
> Xiao Yang<yangx.jy@cn.fujitsu.com>  writes:
>> [root@RHEL6U9GA_Intel64 blktests]# make
>> make -C src all
>> make[1]: Entering directory `/root/blktests/src'
>> cc -Wall -o sg/syzkaller1 -O2 sg/syzkaller1.c
>> sg/syzkaller1.c: In function =E2=80=98segv_handler=E2=80=99:
>> sg/syzkaller1.c:118: warning: implicit declaration of function
>> =E2=80=98__atomic_load_n=E2=80=99
>> sg/syzkaller1.c:118: error: =E2=80=98__ATOMIC_RELAXED=E2=80=99 undecla=
red (first use
>> in this function)
>> sg/syzkaller1.c:118: error: (Each undeclared identifier is reported
>> only once
>> sg/syzkaller1.c:118: error: for each function it appears in.)
>> sg/syzkaller1.c: In function =E2=80=98syz_open_dev=E2=80=99:
>> sg/syzkaller1.c:204: warning: implicit declaration of function
>> =E2=80=98__atomic_fetch_add=E2=80=99
>> sg/syzkaller1.c:204: error: =E2=80=98__ATOMIC_SEQ_CST=E2=80=99 undecla=
red (first use
>> in this function)
>> sg/syzkaller1.c:204: warning: implicit declaration of function
>> =E2=80=98__atomic_fetch_sub=E2=80=99
>> sg/syzkaller1.c: In function =E2=80=98test=E2=80=99:
>> sg/syzkaller1.c:406: error: =E2=80=98__ATOMIC_SEQ_CST=E2=80=99 undecla=
red (first use
>> in this function)
>> make[1]: *** [sg/syzkaller1] Error 1
>> make[1]: Leaving directory `/root/blktests/src'
>> make: *** [all] Error 2
>> ----------------------------------------------------------------------=
-------------------------------------------------
>>
>> It seems that __atomic_* functions are not available, and could you
>> tell me how to fix
>> the compiler error?
> It seems like gcc 4.4 is too old to handle __ATOMIC_*. The oldest
> version of gcc I tried was 4.8 which could handle this code perfectly
> fine.
>
> I think we need hacks in the makefile to see which compiler version we
> have and conditionally compile the code.
Hi Johannes,

Thanks for your quick reply.  i will try to fix it as you suggested.

Thanks,
Xiao Yang
> Byte,
>          Johannes
>



