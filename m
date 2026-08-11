Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868338E11A
	for <fstests@vger.kernel.org>; Tue, 11 Aug 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412140; cv=none; b=gMJMvIl9EGrEZA18T62zz3Ye5W/WXTsLPdNmk9fuJrBW7iZM0nxucbS7ISNfBIDRWSGeaxlxJzIhlfsodPTdbIyISqBa/qgpvtj64wxqfmqrxH69nS/mAWzMHLV8WnmBEaCt6up6N0DyjUFnGgTknXwG1d8hidFI4Utjx1wm2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412140; c=relaxed/simple;
	bh=Kigb3IT9Cu09vkj2sNPSfxwxI2CHysq1VMpFiEEjoZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N1xp4vmkexANMUk0uxlCE4ontIfA3OQLGxE/OyQekbkB0zqgJ0mJfAn9xy4dII7aMrlYaJyyTmkLZs8HCvznRuYmfR2kFxHHahPdxI+kdwwzNy9WtVZyxe6Alg1TL05Ub9/MGUhb4D8MoA4nGMrIMvdTEtn+VTp9Gom9J1pbp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hJvMM0cWKzYQtmJ
	for <fstests@vger.kernel.org>; Tue, 11 Aug 2026 09:35:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 937A54056E
	for <fstests@vger.kernel.org>; Tue, 11 Aug 2026 09:35:29 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kVgfHpqNmx9Bw--.54341S3;
	Tue, 11 Aug 2026 09:35:29 +0800 (CST)
Message-ID: <82176b40-17fe-4018-a0ef-1b89e4648f4a@huaweicloud.com>
Date: Tue, 11 Aug 2026 09:35:27 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idmapped-mounts: probe O_TMPFILE support with the
 caller's mapped id
To: Zizhi Wo <wozizhi@huaweicloud.com>, Christian Brauner
 <brauner@kernel.org>, fstests@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
 <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com>
 <anoyQqDV_ga7ttCg@zlang-mailbox>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <anoyQqDV_ga7ttCg@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD35kVgfHpqNmx9Bw--.54341S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1xCr1xXF1xtr45CFykZrb_yoWfGrWrpa
	95XF98trWIqr1agw1DtF17KFy5trZ3Gr1jqrnrCa4fAasIkFyfXr1xKF1F93s8uryfWa4U
	Xw4DX39xWa98KF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/8/11 4:40, Zorro Lang 写道:
> On Thu, Aug 06, 2026 at 02:11:55PM +0800, Zizhi Wo wrote:
>> friendly ping...
> 
> Hi Zizhi, actually I'm waiting for the fix from vfs list.

Sorry, I hadn't noticed that this issue had already been discussed and
fixed by the community. Thanks for pointing it out.

Thanks,
Zizhi Wo

> 
> Hi Christian,
> 
> Could you please take a look at this issue? Quite a few people have submitted
> patches trying to fix this test issue. Given that you are the authority on
> this topic and previously sent a patchset [1] to fix this kind of issue, I think
> accepting your patch would be the best approach to stay aligned with upstream
> VFS. Christoph also metioned that [2] last time. I don't want to make this issue
> fixing any more complicated. Could you please provide your review point or
> rebase your fix on the latest fstests for-next branch, we'll review it ASAP.
> 
> [1]
> https://lore.kernel.org/fstests/20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org/
> 
> [2]
> https://lore.kernel.org/fstests/amCGrQi2sCcgSgHL@infradead.org/
> 
> Thanks,
> Zorro
> 
>>
>> 在 2026/7/31 17:02, Zizhi Wo 写道:
>>> From: Zizhi Wo <wozizhi@huawei.com>
>>>
>>> Kernel commit 539dce114465 ("fs: refuse O_TMPFILE creation with an
>>> unmapped fsuid or fsgid") made vfs_tmpfile() return -EOVERFLOW when the
>>> caller's fsuid/fsgid has no mapping in the filesystem's user namespace
>>> after applying the mount's idmapping. This is a no-op on non-idmapped
>>> mounts and only takes effect on an idmapped mount that does not map the
>>> caller.
>>>
>>> The idmapped-mount testcases behind generic/696 and generic/697 build an
>>> idmapping (e.g. "0 10000 10000") that covers host uid 10000-19999 but
>>> not uid 0, then call openat_tmpfile_supported() from the parent process
>>> that is still real root (fsuid 0). The probe now gets -EOVERFLOW, falls
>>> into the log_errno() branch, and prints
>>>
>>>     utils.c: 928: openat_tmpfile_supported - Value too large for defined \
>>> data type - failure: create
>>>
>>> to stderr. Both testcases expect "Silence is golden", so this spurious
>>> output fails them, even though the kernel behavior is correct and the
>>> testcases' own assertions all pass.
>>>
>>> Move each openat_tmpfile_supported() call into the child, after
>>> switch_ids()/switch_userns(), so it probes with the mapped identity the
>>> tmpfile section uses. Silencing EOVERFLOW in openat_tmpfile_supported()
>>> would make it indistinguishable whether the idmapping genuinely has no
>>> mapping for any caller, or the probe just ran in the unmapped parent before
>>> the switch.
>>>
>>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>>> ---
>>>    src/vfs/idmapped-mounts.c | 32 ++++++++++++++++++++------------
>>>    1 file changed, 20 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
>>> index ed9992f9..bfbe9042 100644
>>> --- a/src/vfs/idmapped-mounts.c
>>> +++ b/src/vfs/idmapped-mounts.c
>>> @@ -3838,8 +3838,6 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
>>>    		goto out;
>>>    	}
>>> -	supported = openat_tmpfile_supported(open_tree_fd);
>>> -
>>>    	pid = fork();
>>>    	if (pid < 0) {
>>>    		log_stderr("failure: fork");
>>> @@ -3849,6 +3847,8 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
>>>    		if (!switch_ids(10000, 11000))
>>>    			die("failure: switch fsids");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		/* create regular file via open() */
>>>    		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>>>    		if (file1_fd < 0)
>>> @@ -4014,8 +4014,6 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>>>    		goto out;
>>>    	}
>>> -	supported = openat_tmpfile_supported(open_tree_fd);
>>> -
>>>    	pid = fork();
>>>    	if (pid < 0) {
>>>    		log_stderr("failure: fork");
>>> @@ -4025,6 +4023,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>>>    		if (!switch_userns(attr.userns_fd, 0, 0, false))
>>>    			die("failure: switch_userns");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		/* create regular file via open() */
>>>    		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>>>    		if (file1_fd < 0)
>>> @@ -4133,6 +4133,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>>>    		if (!switch_userns(attr.userns_fd, 0, 0, false))
>>>    			die("failure: switch_userns");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		if (!caps_down_fsetid())
>>>    			die("failure: caps_down_fsetid");
>>> @@ -4257,6 +4259,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>>>    		if (!switch_userns(attr.userns_fd, 0, 1000, false))
>>>    			die("failure: switch_userns");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		if (!caps_down_fsetid())
>>>    			die("failure: caps_down_fsetid");
>>> @@ -7733,8 +7737,6 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
>>>    		goto out;
>>>    	}
>>> -	supported = openat_tmpfile_supported(open_tree_fd);
>>> -
>>>    	pid = fork();
>>>    	if (pid < 0) {
>>>    		log_stderr("failure: fork");
>>> @@ -7752,6 +7754,8 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
>>>    		if (!switch_ids(10000, 11000))
>>>    			die("failure: switch fsids");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		/* create regular file via open() */
>>>    		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>>>    		if (file1_fd < 0)
>>> @@ -7947,8 +7951,6 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
>>>    		goto out;
>>>    	}
>>> -	supported = openat_tmpfile_supported(open_tree_fd);
>>> -
>>>    	/*
>>>    	 * Below we verify that setgid inheritance for a newly created file or
>>>    	 * directory works correctly. As part of this we need to verify that
>>> @@ -7984,6 +7986,8 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
>>>    		if (!switch_userns(attr.userns_fd, 0, 0, false))
>>>    			die("failure: switch_userns");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		if (!caps_down_fsetid())
>>>    			die("failure: caps_down_fsetid");
>>> @@ -8181,8 +8185,6 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
>>>    		goto out;
>>>    	}
>>> -	supported = openat_tmpfile_supported(open_tree_fd);
>>> -
>>>    	pid = fork();
>>>    	if (pid < 0) {
>>>    		log_stderr("failure: fork");
>>> @@ -8207,6 +8209,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
>>>    		if (!switch_ids(10000, 11000))
>>>    			die("failure: switch fsids");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		/* create regular file via open() */
>>>    		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>>>    		if (file1_fd < 0)
>>> @@ -8342,6 +8346,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
>>>    		if (!switch_ids(10000, 11000))
>>>    			die("failure: switch fsids");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		/* create regular file via open() */
>>>    		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>>>    		if (file1_fd < 0)
>>> @@ -8536,8 +8542,6 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
>>>    		goto out;
>>>    	}
>>> -	supported = openat_tmpfile_supported(open_tree_fd);
>>> -
>>>    	/*
>>>    	 * Below we verify that setgid inheritance for a newly created file or
>>>    	 * directory works correctly. As part of this we need to verify that
>>> @@ -8580,6 +8584,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
>>>    		if (!switch_userns(attr.userns_fd, 0, 0, false))
>>>    			die("failure: switch_userns");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		if (!caps_down_fsetid())
>>>    			die("failure: caps_down_fsetid");
>>> @@ -8723,6 +8729,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
>>>    		if (!switch_userns(attr.userns_fd, 0, 0, false))
>>>    			die("failure: switch_userns");
>>> +		supported = openat_tmpfile_supported(open_tree_fd);
>>> +
>>>    		if (!caps_down_fsetid())
>>>    			die("failure: caps_down_fsetid");
>>
> 

