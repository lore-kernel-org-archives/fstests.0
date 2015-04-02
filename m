Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36173 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbDBNRo convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2015 09:17:44 -0400
Received: by iedm5 with SMTP id m5so68515964ied.3
        for <fstests@vger.kernel.org>; Thu, 02 Apr 2015 06:17:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <alpine.LFD.2.00.1503301522190.8076@localhost.localdomain>
References: <9a1c40cb9eceb72543647cb4209269bc4aba86f0.1427706679.git.zhaolei@cn.fujitsu.com>
	<alpine.LFD.2.00.1503301522190.8076@localhost.localdomain>
Date: Thu, 2 Apr 2015 14:17:43 +0100
Message-ID: <CAL3q7H4vSiV1kA+OovLpXD9vz9ayLL+vDYYaMyyGy4aiWd+TOw@mail.gmail.com>
Subject: Re: [PATCH] Fix caller's argument for _require_command()
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: Zhaolei <zhaolei@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 30, 2015 at 2:25 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> On Mon, 30 Mar 2015, Zhaolei wrote:
>
>> Date: Mon, 30 Mar 2015 17:11:27 +0800
>> From: Zhaolei <zhaolei@cn.fujitsu.com>
>> To: fstests@vger.kernel.org
>> Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
>> Subject: [PATCH] Fix caller's argument for _require_command()
>>
>> From: Zhao Lei <zhaolei@cn.fujitsu.com>
>>
>> _require_command() only accept 2 arguments but some caller
>> misused this function, and caused "not_run" after we limit
>> calling way.
>>
>> This patch fixed above caller.
>>
>> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
>> ---
>>  common/defrag | 13 +++++++++----
>>  tests/xfs/094 |  2 +-
>>  tests/xfs/103 |  2 +-
>>  tests/xfs/195 |  2 +-
>>  4 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/common/defrag b/common/defrag
>> index f923dc0..b44ef98 100644
>> --- a/common/defrag
>> +++ b/common/defrag
>> @@ -22,22 +22,27 @@
>>
>>  _require_defrag()
>>  {
>> +    local defrag_cmd
>> +
>>      case "$FSTYP" in
>>      xfs)
>> -        DEFRAG_PROG="$XFS_FSR_PROG"
>> +        defrag_cmd="$XFS_FSR_PROG"
>> +        DEFRAG_PROG="$defrag_cmd"
>>       ;;
>>      ext4|ext4dev)
>> -        DEFRAG_PROG="$E4DEFRAG_PROG"
>> +        defrag_cmd="$E4DEFRAG_PROG"
>> +        DEFRAG_PROG="$defrag_cmd"
>>       ;;
>>      btrfs)
>> -     DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
>> +        defrag_cmd="$BTRFS_UTIL_PROG"
>> +        DEFRAG_PROG="defrag_cmd filesystem defragment"
>>       ;;
>>      *)
>>          _notrun "defragmentation not supported for fstype \"$FSTYP\""
>>       ;;
>>      esac
>>
>> -    _require_command "$DEFRAG_PROG" defragment
>> +    _require_command "$defrag_cmd" defragment
>
> Hi,
>
> what's the point of this change ?

Lukas, this is response to my comment at:

https://patchwork.kernel.org/patch/6016291/

But still I agree with you, this change seems a bit to come out of
thin air. A more detailed explanation on the commit message would
help, perhaps giving the example of btrfs/005 failing due to the
reason I pointed out.

>
>>      _require_xfs_io_command "fiemap"
>>  }
>>
>> diff --git a/tests/xfs/094 b/tests/xfs/094
>> index cee42d6..5c6e98d 100755
>> --- a/tests/xfs/094
>> +++ b/tests/xfs/094
>> @@ -46,7 +46,7 @@ _supported_fs xfs
>>  _supported_os IRIX Linux
>>  _require_realtime
>>  _require_scratch
>> -_require_command "$XFS_IO_PROG" xfs_io
>> +[ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
>
> Why ? Do not we get the same result from
>
> _require_command "$XFS_IO_PROG" xfs_io
>
> anyway if the $XFS_IO_PROG isn't set ?

Agreed. Seems unneeded because XFS_IO_PROG is always a single word
therefore not causing a problem like btrfs' "btrfs filesystem
defragment" case.

>
> -Lukas
>
>>
>>  _filter_realtime_flag()
>>  {
>> diff --git a/tests/xfs/103 b/tests/xfs/103
>> index cbe884f..d80dbf2 100755
>> --- a/tests/xfs/103
>> +++ b/tests/xfs/103
>> @@ -66,7 +66,7 @@ _filter_noymlinks_flag()
>>  # real QA test starts here
>>  _supported_os Linux IRIX
>>  _supported_fs xfs
>> -_require_command "$XFS_IO_PROG" xfs_io
>> +[ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
>>  _require_scratch
>>
>>  _create_scratch
>> diff --git a/tests/xfs/195 b/tests/xfs/195
>> index 21fcb00..075022d 100755
>> --- a/tests/xfs/195
>> +++ b/tests/xfs/195
>> @@ -65,7 +65,7 @@ _supported_os Linux
>>
>>  _require_test
>>  _require_user
>> -_require_command "$XFSDUMP_PROG" xfsdump
>> +[ "$XFSDUMP_PROG" = "" ] && _notrun "xfsdump not found"
>>
>>  echo "Preparing subtree"
>>  mkdir $TEST_DIR/d
>>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
