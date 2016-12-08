Received: from cn.fujitsu.com ([59.151.112.132]:15121 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752738AbcLHFpU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Dec 2016 00:45:20 -0500
Subject: Re: [PATCH 1/2] fstests: common: rename and enhance _require_btrfs to
 _require_btrfs_subcommand
References: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
 <20161208040043.GE29149@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <677a705c-cd4c-a902-264c-d6542dd69514@cn.fujitsu.com>
Date: Thu, 8 Dec 2016 13:44:55 +0800
MIME-Version: 1.0
In-Reply-To: <20161208040043.GE29149@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 12/08/2016 12:00 PM, Eryu Guan wrote:
> On Thu, Dec 08, 2016 at 10:04:55AM +0800, Qu Wenruo wrote:
>> Rename _require_btrfs() to _require_btrfs_subcommand() to avoid
>> confusion, as all other _require_btrfs_* has a quite clear suffix, lik=
e
>> _require_btrfs_mkfs_feature() or _require_btrfs_fs_feature().
>>
>> Also enhance _require_btrfs_subcommand() to accept 2nd level commands =
or
>> options.
>> Options will be determined by the first "-" char.
>> This is quite useful for case like "btrfs inspect-internal dump-tree"
>> and "btrfs check --qgroup-report".
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  common/rc       | 29 ++++++++++++++++++++++++-----
>
> Can you rebase on top of current master please? We've moved
> btrfs-specific functions to common/btrfs

Finally=EF=BC=81
Good news.

>
>>  tests/btrfs/004 |  3 ++-
>>  tests/btrfs/048 |  2 +-
>>  tests/btrfs/059 |  2 +-
>>  tests/btrfs/131 |  2 +-
>>  5 files changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 8c99306..1703232 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3019,15 +3019,34 @@ _require_deletable_scratch_dev_pool()
>>  }
>>
>>  # We check for btrfs and (optionally) features of the btrfs command
>> -_require_btrfs()
>> +# _require_btrfs_subcommand <subcommand> [<subfunction>|<option>]
>> +# It can handle both subfunction like "inspect-internal dump-tree"
>> +# and options like "check --qgroup-report"
>> +_require_btrfs_subcommand()
>
> I'd prefer a name similar to _require_xfs_io_command, e.g.
> _require_btrfs_command, "subcommand" seems not necessary to me.
>

Right, the subcommand seems not that handy compared to other _require_*.


>>  {
>> -	cmd=3D$1
>> -	_require_command "$BTRFS_UTIL_PROG" btrfs
>>  	if [ -z "$1" ]; then
>> -		return 1;
>> +		echo "Usage: _require_btrfs_subcommand command [subcommand]" 1>&2
>> +		exit 1
>>  	fi
>> -	$BTRFS_UTIL_PROG $cmd --help >/dev/null 2>&1
>> +	cmd=3D$1
>> +	param=3D$2
>> +
>> +	_require_command "$BTRFS_UTIL_PROG" btrfs
>> +	$BTRFS_UTIL_PROG $cmd --help &>/dev/null
>>  	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd=
)"
>> +
>> +	test -z "$param" && return
>> +
>> +	# if $param is an option, replace leading "-"s for grep
>> +	if [ ${param:0:1} =3D=3D "-" ]; then
>> +		param=3D$(echo $param | sed 's/^-*//')
>> +		$BTRFS_UTIL_PROG $cmd --help | grep $param > /dev/null || \
>
> Use "grep -w" to be safer? And "-q" instead of "> /dev/null"

Right, -w is much safer. I'll use "-q" in next version.

>
>> +			_not_run "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
>
> $param here is without leading "-", so the _notrun message is kind of
> misleading. And _notrun not _not_run :)

Right, I'll using safe_param.

Thanks,
Qu

>
> Thanks,
> Eryu
>
>


