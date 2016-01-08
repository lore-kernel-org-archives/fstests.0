Received: from mail-ob0-f195.google.com ([209.85.214.195]:34115 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbcAHN2e (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 8 Jan 2016 08:28:34 -0500
Received: by mail-ob0-f195.google.com with SMTP id q2so29485724obl.1
        for <fstests@vger.kernel.org>; Fri, 08 Jan 2016 05:28:34 -0800 (PST)
Subject: Re: [PATCH 1/2] fstests: comments to prevent from adding "/" to the
 end of 2 environment variables
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
 <1452148649-22451-2-git-send-email-hejianet@gmail.com>
 <20160107102723.GD21019@eguan.usersys.redhat.com>
 <568E7049.1020508@gmail.com>
 <20160108093912.GH21019@eguan.usersys.redhat.com>
From: hejianet <hejianet@gmail.com>
Message-ID: <568FB97E.7020202@gmail.com>
Date: Fri, 8 Jan 2016 21:28:30 +0800
MIME-Version: 1.0
In-Reply-To: <20160108093912.GH21019@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu
Yes, you are wright

root@justin-u1504:~/xfstests/xfstests# ./check -d xfs/003
common/config: Error: $TEST_DIR (/root/xfstests/test1) is not a directory

B.R.
Justin

=E5=9C=A8 1/8/16 5:39 PM, Eryu Guan =E5=86=99=E9=81=93:
> On Thu, Jan 07, 2016 at 10:03:53PM +0800, hejianet wrote:
>> Hi Eryu Guan
>> Thanks for the comments,  reasonable to me.
>> I will add it into v2 patch together with other
>> =E5=9C=A8 1/7/16 6:27 PM, Eryu Guan =E5=86=99=E9=81=93:
>>> On Thu, Jan 07, 2016 at 02:37:28PM +0800, Jia He wrote:
>>>> This adds comments to prevent user from adding "/" to the end of TES=
T_DIR and
>>>> SCRATCH_MNT
>>> Instead of adding comments, how about removing the trailing "/" in th=
e
>>> code, something like:
>>>
>>> diff --git a/common/config b/common/config
>>> index e82d279..cb34fd7 100644
>>> --- a/common/config
>>> +++ b/common/config
>>> @@ -551,5 +551,10 @@ if [ -z "$CONFIG_INCLUDED" ]; then
>>>   	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
>>>   fi
>>> +# canonicalize the mount points
>>> +# this follows symlinks and removes all trailing "/"s
>>> +export TEST_DIR=3D`readlink -e "$TEST_DIR"`
>>> +export SCRATCH_MNT=3D`readlink -e "$SCRATCH_MNT"`
>>> +
>> Thanks, but maybe it will empty the invalid path and the user doesn't =
know
>> why his TEST_DIR/SCRATCH_MNT are assigned to NULL?
> These values have been proved to be a directory in get_next_config(), i=
f
> they're not, the test errors out there.
>
> Thanks,
> Eryu
>

