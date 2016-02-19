Received: from sandeen.net ([63.231.237.45]:39295 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424088AbcBSQfK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Feb 2016 11:35:10 -0500
Subject: Re: [PATCH] xfs: change return value check to golden image check
References: <1455208656-16637-1-git-send-email-zlang@redhat.com>
 <20160219013316.GW14668@dastard>
 <254524291.19728857.1455896123254.JavaMail.zimbra@redhat.com>
 <56C73BC2.7090506@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <56C7443C.5050203@sandeen.net>
Date: Fri, 19 Feb 2016 10:35:08 -0600
MIME-Version: 1.0
In-Reply-To: <56C73BC2.7090506@sandeen.net>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>



On 2/19/16 9:58 AM, Eric Sandeen wrote:
>=20
>=20
> On 2/19/16 9:35 AM, Zirong Lang wrote:
>>
>>
>> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
>>> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, eguan@redhat.com
>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=BA=94, 20=
16=E5=B9=B4 2 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 9:33:16
>>> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs: change return value check to gol=
den image check
>>>
>>> On Fri, Feb 12, 2016 at 12:37:36AM +0800, Zorro Lang wrote:
>>>> xfs/133 and xfs/138 use too much code to do "return value" check,
>>>> it's not necessary. For the code can be more readable and clear,
>>>> I change "return value" check to golden image check.
>>>>
>>>> Signed-off-by: Zorro Lang <zlang@redhat.com>
>>>> ---
>>>>  tests/xfs/133     | 20 +++++++-------------
>>>>  tests/xfs/133.out |  7 +++++++
>>>>  tests/xfs/138     | 26 ++++++++++++--------------
>>>>  tests/xfs/138.out | 12 ++++++++++++
>>>>  4 files changed, 38 insertions(+), 27 deletions(-)
>>>
>>> This cause a xfs/133 failure like this on my systems:
>>>
>>> --- tests/xfs/133.out   2016-02-19 10:40:57.043131919 +1100
>>> +++ /home/dave/src/xfstests-dev/results//xfs/xfs/133.out.bad    2016-=
02-19
>>> 12:24:53.173589432 +1100
>>> @@ -4,5 +4,6 @@
>>>  Filesystem Blocks Quota Limit Warn/Time Mounted on
>>>  SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
>>>  =3D=3D=3D report command output =3D=3D=3D
>>> +(null) 0 0 0 00 [--------]
>=20
> I need to dig, but this may be a result of GETNEXTQUOTA additions to
> xfs_quota.
>=20
> We can now find IDs on disk that don't exist in the user database, and
> we would not have reported them before.
>=20
> Perhaps change the test to report ids not names, to debug it and see
> which one it is finding?
>=20
> I'm guessing it's ID 0, but I have to think about whether that's correc=
t
> to show or not...

Ok, with Zorro's help, we see that this is a result of GETNEXTQUOTA.

With that in place, "report" shows all active quotas, skipping only
if XFS_IS_DQUOT_UNINITIALIZED().  But project ID 0 has 4 inodes
accounted for:

# xfs_db -c "dquot -p 0" -c print /dev/...
...
diskdq.bcount =3D 0
diskdq.icount =3D 4
diskdq.itimer =3D 0
diskdq.btimer =3D 0
...

We never reported ID 0 before, because it was not in the projects file.
But it looks active, so GETNEXTQUOTA finds and returns it now.

I'm not actually sure what the best way is to fix this; I was even on
the fence about using GETNEXTQUOTA for project quotas at all, because
we always have a local file of projects to iterate anyway.

We could explicitly look up id 0 and not show it if it's not in the
projects file.

We could not use GETNEXTQUOTA in the kernel for project quotas.

We could skip printing id 0 altogether in xfs_quota

We could filter it out in the test ...

-Eric
