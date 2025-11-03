Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8227B348
	for <fstests@vger.kernel.org>; Mon,  3 Nov 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134822; cv=none; b=YZy2w86oPr9vAwlvX6Ld3XtqyOwlyB+ONZGRn+lOHrZr8fjRCxozKDyNUSr9JI8W+YGnkBqkMMn1bQr11DwWgmu8uKz1ggycCjUoz6Gtl/i/PHGeB/NwyuevNr3dkXIoV0vpNBt1F08ffZ7NMcAtrFWB+hQKt4rg3rlMw61IhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134822; c=relaxed/simple;
	bh=lNa5OqdXIHwW+gcJnZqYyTQZxgVka1Qit/FyXIF6UA8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fAuqgxfJZ6arCEIYR0GhEz5NyKsTCZUJgJ28qFV+KLthlD4nYuJUFFiUukOnICDKfO03J1GXtulgo9FUImxxBpwx0CAIn+dW5rquPUnNXeUJN5K8KMKvg998AlnlyuPlu3OA99KhOFPaeFDdCDAzvRaeognwsQGKR2rerOOmoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goaNOkeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goaNOkeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66183C4CEF7;
	Mon,  3 Nov 2025 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762134822;
	bh=lNa5OqdXIHwW+gcJnZqYyTQZxgVka1Qit/FyXIF6UA8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=goaNOkeTVRFMRKjROGrMklriX3CJ2aucoQ79lXz+fWQ5fhrp4LwGvLvJeXmvQDPOE
	 jog1lFJdp7AjFWNCGFbkWirHNZEmV1NEoBoQ6AtsDK/B8LCkGrO5qcf7gTbcOU3OYB
	 G0R7FocRlJTLhRoe6/sjZv5mEKlUsinwTkYkvj5zcT9J6wyGPkwHc6sELQCh1ABlbm
	 K+AxNHxwr+J5XySXHns7lSTEsQiZ0S+H4U9wlpCWSoQeioMsRS8Dz/gadPQGqOTnFB
	 NswxgFIYC4vrhkzAWWxcymXoHOd3Cy3rghwyGsIhR+vWZuUalFuNdxeu3Sz0xy4LrS
	 kiSCoOhr5NO+g==
Message-ID: <207c9423-c776-4be1-a440-a3674d06416c@kernel.org>
Date: Mon, 3 Nov 2025 09:53:39 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs/022: fix to run testcase correctly
To: Zorro Lang <zlang@redhat.com>
References: <20251020023108.327728-1-chao@kernel.org>
 <20251020023108.327728-2-chao@kernel.org>
 <20251101114453.g6fxupmriauxtroc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251101114453.g6fxupmriauxtroc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 19:44, Zorro Lang wrote:
> On Mon, Oct 20, 2025 at 10:31:08AM +0800, Chao Yu wrote:
>> f2fs/022 will report failure as below:
>>
>> f2fs/022       - output mismatch (see /share/git/fstests/results//f2fs/022.out.bad)
>>     --- tests/f2fs/022.out      2025-10-20 10:18:47.075968669 +0800
>>     +++ /share/git/fstests/results//f2fs/022.out.bad    2025-10-20 10:25:20.000000000 +0800
>>     @@ -1,2 +1,5 @@
>>      QA output created by 022
>>     +wrote 8388608/8388608 bytes at offset 0
>>     +8 MiB, 2048 ops; 0.0018 sec (4.300 GiB/sec and 1127132.6362 ops/sec)
>>     +fallocate: Operation not supported
>>      Silence is golden
>>     ...
>>     (Run 'diff -u /share/git/fstests/tests/f2fs/022.out /share/git/fstests/results//f2fs/022.out.bad'  to see the entire diff)
>>
>> HINT: You _MAY_ be missing kernel fix:
>>       xxxxxxxxxxxx f2fs: fix to do sanity check on node footer for non inode dnode
>>
>> Fix this testcase as below:
>>
>> - fix a typo "$SCARTCH_MNT"
>> - fix to update output to "fallocate: Structure needs cleaning"
>> - relocate output of "$XFS_IO_PROG $foo_path -c "pwrite 0 8M"" to
>> $seqres.full
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/022     | 8 +++-----
>>  tests/f2fs/022.out | 2 +-
>>  2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/f2fs/022 b/tests/f2fs/022
>> index f6d77c96..728ef4e8 100755
>> --- a/tests/f2fs/022
>> +++ b/tests/f2fs/022
>> @@ -24,15 +24,15 @@ _require_inject_f2fs_command node i_nid
>>  # remove all mkfs options to avoid layout change of on-disk inode
>>  export MKFS_OPTIONS=""
>>  
>> -foo_path=$SCARTCH_MNT/foo
>> -bar_path=$SCARTCH_MNT/bar
>> +foo_path=$SCRATCH_MNT/foo
>> +bar_path=$SCRATCH_MNT/bar
> 
> Hahaha, I took long time to find out what these 2 lines try to change:) Thanks
> for fixing this.

Haha, Seems I rebased v2 to a problematic codebase when I sync-up code from
different git repo. It took me some time to find the root cause of 022
failure. :/

Anyway, thanks for the review. :)

Thanks,

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>  
>>  _scratch_mkfs >> $seqres.full
>>  _scratch_mount
>>  
>>  touch $foo_path
>>  touch $bar_path
>> -$XFS_IO_PROG $foo_path -c "pwrite 0 8M"
>> +$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
>>  sync
>>  foo_ino=`stat -c '%i' $foo_path`
>>  bar_ino=`stat -c '%i' $bar_path`
>> @@ -48,7 +48,5 @@ _scratch_mount
>>  $XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
>>  _scratch_unmount
>>  
>> -echo "Silence is golden"
>> -
>>  status=0
>>  exit
>> diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
>> index 394c6a7c..5307e3d7 100644
>> --- a/tests/f2fs/022.out
>> +++ b/tests/f2fs/022.out
>> @@ -1,2 +1,2 @@
>>  QA output created by 022
>> -Silence is golden
>> +fallocate: Structure needs cleaning
>> -- 
>> 2.49.0
>>
> 

