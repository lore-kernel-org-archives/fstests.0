Received: from smtpbg64.qq.com ([103.7.28.238]:30773 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdLAGqT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 1 Dec 2017 01:46:19 -0500
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
From: Chengguang Xu <cgxu@mykernel.net>
In-Reply-To: <20171201041301.GB2749@eguan.usersys.redhat.com>
Date: Fri, 1 Dec 2017 14:38:57 +0800
Message-Id: <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
 <20171201041301.GB2749@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


> =D4=DA 2017=C4=EA12=D4=C21=C8=D5=A3=AC=CF=C2=CE=E712:13=A3=ACEryu Guan =
<eguan@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
> On Fri, Dec 01, 2017 at 12:04:44PM +0800, Chengguang Xu wrote:
>> Hi Eryu,
>>=20
>> Actually, in my another test case generic/470 will need to check wheth=
er fs supports syncfs or not.=20
>> I make shared infrastructure for checking that, and because it is comm=
on component=20
>> I post as an individual patch instead of including in the case of gene=
ric/470.
>=20
> I think "_require_xfs_io_command syncfs" should be fine, there's no nee=
d
> & not encouraged to add new binary & usage like this. If you want to ru=
n
> syncfs(2) to make sure the kernel actually supports it, you can add a
> new 'syncfs' switch case in _require_xfs_io_command.
>=20

Failure of _require_xfs_io_command check leads to notrun, if we have seve=
ral
sync patterns(combination of fsync/fdatasync/syncfs/sync) in an actual te=
st case,=20
the case will lose downward compatibility for old kernel.
In this situation, we have to split test case though they look similar.

Thanks=A3=AC
Chengguang.