Received: from mx2.suse.de ([195.135.220.15]:53758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762154AbdLSKx2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Dec 2017 05:53:28 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted whole-dev
References: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com>
        <20171204082923.GF2749@eguan.usersys.redhat.com>
        <5A251225.7080905@cn.fujitsu.com>
        <20171204092558.GH2749@eguan.usersys.redhat.com>
        <5A2519F4.5040102@cn.fujitsu.com>
        <20171204182953.GA16308@vader.DHCP.thefacebook.com>
        <5A38EDAF.5070407@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 11:53:26 +0100
In-Reply-To: <5A38EDAF.5070407@cn.fujitsu.com> (Xiao Yang's message of "Tue,
        19 Dec 2017 18:45:03 +0800")
Message-ID: <mqd3747at09.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Omar Sandoval <osandov@osandov.com>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Xiao Yang <yangx.jy@cn.fujitsu.com> writes:
> [root@RHEL6U9GA_Intel64 blktests]# make
> make -C src all
> make[1]: Entering directory `/root/blktests/src'
> cc -Wall -o sg/syzkaller1 -O2 sg/syzkaller1.c
> sg/syzkaller1.c: In function =E2=80=98segv_handler=E2=80=99:
> sg/syzkaller1.c:118: warning: implicit declaration of function
> =E2=80=98__atomic_load_n=E2=80=99
> sg/syzkaller1.c:118: error: =E2=80=98__ATOMIC_RELAXED=E2=80=99 undeclar=
ed (first use
> in this function)
> sg/syzkaller1.c:118: error: (Each undeclared identifier is reported
> only once
> sg/syzkaller1.c:118: error: for each function it appears in.)
> sg/syzkaller1.c: In function =E2=80=98syz_open_dev=E2=80=99:
> sg/syzkaller1.c:204: warning: implicit declaration of function
> =E2=80=98__atomic_fetch_add=E2=80=99
> sg/syzkaller1.c:204: error: =E2=80=98__ATOMIC_SEQ_CST=E2=80=99 undeclar=
ed (first use
> in this function)
> sg/syzkaller1.c:204: warning: implicit declaration of function
> =E2=80=98__atomic_fetch_sub=E2=80=99
> sg/syzkaller1.c: In function =E2=80=98test=E2=80=99:
> sg/syzkaller1.c:406: error: =E2=80=98__ATOMIC_SEQ_CST=E2=80=99 undeclar=
ed (first use
> in this function)
> make[1]: *** [sg/syzkaller1] Error 1
> make[1]: Leaving directory `/root/blktests/src'
> make: *** [all] Error 2
> -----------------------------------------------------------------------=
------------------------------------------------
>
> It seems that __atomic_* functions are not available, and could you
> tell me how to fix
> the compiler error?

It seems like gcc 4.4 is too old to handle __ATOMIC_*. The oldest
version of gcc I tried was 4.8 which could handle this code perfectly
fine.

I think we need hacks in the makefile to see which compiler version we
have and conditionally compile the code.

Byte,
        Johannes

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
