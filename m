Received: from sandeen.net ([63.231.237.45]:55894 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbcFVDFo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 23:05:44 -0400
Subject: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fail_at_unmount
 error handling
References: <1466429073-10124-1-git-send-email-zlang@redhat.com>
 <1466429073-10124-2-git-send-email-zlang@redhat.com>
 <20160621070818.GT5140@eguan.usersys.redhat.com>
 <20160622000040.GF27480@dastard>
 <241381551.489652.1466559773511.JavaMail.zimbra@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <696ce99d-dfa9-70a0-29c2-e605a3d71285@sandeen.net>
Date: Tue, 21 Jun 2016 22:04:55 -0500
MIME-Version: 1.0
In-Reply-To: <241381551.489652.1466559773511.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On 6/21/16 8:42 PM, Zirong Lang wrote:
> Hi Dave
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Eryu Guan" <eguan@redhat.com>
>> =E6=8A=84=E9=80=81: "Zorro Lang" <zlang@redhat.com>, fstests@vger.kern=
el.org, sandeen@redhat.com, cem@redhat.com
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 201=
6=E5=B9=B4 6 =E6=9C=88 22=E6=97=A5 =E4=B8=8A=E5=8D=88 8:00:40
>> =E4=B8=BB=E9=A2=98: Re: [PATCH v4 2/2] xfs/006: new case to test xfs f=
ail_at_unmount error handling
>>
>> On Tue, Jun 21, 2016 at 03:08:18PM +0800, Eryu Guan wrote:
>>> On Mon, Jun 20, 2016 at 09:24:33PM +0800, Zorro Lang wrote:
>>>> +# real QA test starts here
>>>> +_supported_fs xfs
>>>> +_supported_os Linux
>>>> +_require_dm_target error
>>>> +_require_scratch
>>>> +
>>>> +_scratch_mkfs > $seqres.full 2>&1
>>>> +_require_fs_sysfs $SCRATCH_DEV error/fail_at_unmount
>>>
>>> Usually we call _require_xxx before mkfs and do the real test, a comm=
ent
>>> to explain why we need to mkfs first would be good.
>>
>> Ok, so why do we need to test the scratch device for this
>> sysfs file check? We've already got the test device mounted, and
>> filesystems tend to present identical sysfs control files for all
>> mounted filesystems.
>>
>> i.e. this _require_fs_sysfs() function could just drop the device
>> and check the test device for whether the sysfs entry exists. If it
>> doesn't, then the scratch device isn't going to have it, either.
>=20
> Hmm... at first I thought about if I should use TEST_DEV to do _require=
_fs_sysfs
> checking. But I'm not sure if different devices maybe bring different s=
ysfs
> attributes in, if someone make a special device in one case? So I give =
one more
> argument about device name.

Sorry, I was kind of thinking this as well on my first review, but I let =
it pass.

I would say that for now, let's just use TEST_DEV.  There is no reason to=
 code
around "what-if" scenarios.  If a filesystem ends up needing a special mk=
fs
or mount option to expose a sysfs tunable in the future, we can add a dev=
ice name
at that point. Until then, I don't think there is any reason, and the "mk=
fs first,
then require" is definitely a little bit out of the ordinary.

-Eric
