Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405E3B995E
	for <fstests@vger.kernel.org>; Thu,  6 Aug 2026 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996732; cv=none; b=Metfrs7mP8q0AN3wtmd+nTVr5gSXyRSSF+2P31ABC2H4wP6jpqNJY2wIhwUkN+CPFJDsih5GBX6WDc3TEmhAGv9O/KCmu/3UJsiApSWKZeGCZpWXFHq0paMOJrQo7UG7Z2ZFL6GM2gr5RwDY892pOlSQLDdRsMnpoJw4lLBbQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996732; c=relaxed/simple;
	bh=TToBdAsWj6Mfuk/e9znkHgeBhC36bq7JI79eQClxI3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgCmUF1sPTgO78tT09i7rV0Mf+qCfqcZhYzlJB0pBiO93SpVVdgYTC2I142t8wVnbFM+frrnf83J07N2ivBrpKSueQlybNKO6VfnDUbcPgROmMgdjsS6rK3Qj+S2eyZvKgFvp7mVWf8DpTAU89EF42QBVcYWzUenPzwils16KsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFxkb4CGMzKHMbc
	for <fstests@vger.kernel.org>; Thu,  6 Aug 2026 14:11:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0734A4058D
	for <fstests@vger.kernel.org>; Thu,  6 Aug 2026 14:11:59 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgBHg0KsJXRqZBEwBQ--.54763S3;
	Thu, 06 Aug 2026 14:11:58 +0800 (CST)
Message-ID: <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com>
Date: Thu, 6 Aug 2026 14:11:55 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idmapped-mounts: probe O_TMPFILE support with the
 caller's mapped id
To: Zizhi Wo <wozizhi@huaweicloud.com>, zlang@kernel.org, brauner@kernel.org,
 fstests@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHg0KsJXRqZBEwBQ--.54763S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4ftFW3ZF4DGF45Cr4kZwb_yoWxKry5pa
	nYqr98trWxtF1agw1DJr97KFWfKr4rGw1jgrnFka4fA3WakFZ3ZF4IkF10v345CryfWa47
	Z3yDX398W3y3GF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping...

在 2026/7/31 17:02, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Kernel commit 539dce114465 ("fs: refuse O_TMPFILE creation with an
> unmapped fsuid or fsgid") made vfs_tmpfile() return -EOVERFLOW when the
> caller's fsuid/fsgid has no mapping in the filesystem's user namespace
> after applying the mount's idmapping. This is a no-op on non-idmapped
> mounts and only takes effect on an idmapped mount that does not map the
> caller.
> 
> The idmapped-mount testcases behind generic/696 and generic/697 build an
> idmapping (e.g. "0 10000 10000") that covers host uid 10000-19999 but
> not uid 0, then call openat_tmpfile_supported() from the parent process
> that is still real root (fsuid 0). The probe now gets -EOVERFLOW, falls
> into the log_errno() branch, and prints
> 
>    utils.c: 928: openat_tmpfile_supported - Value too large for defined \
> data type - failure: create
> 
> to stderr. Both testcases expect "Silence is golden", so this spurious
> output fails them, even though the kernel behavior is correct and the
> testcases' own assertions all pass.
> 
> Move each openat_tmpfile_supported() call into the child, after
> switch_ids()/switch_userns(), so it probes with the mapped identity the
> tmpfile section uses. Silencing EOVERFLOW in openat_tmpfile_supported()
> would make it indistinguishable whether the idmapping genuinely has no
> mapping for any caller, or the probe just ran in the unmapped parent before
> the switch.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   src/vfs/idmapped-mounts.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index ed9992f9..bfbe9042 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -3838,8 +3838,6 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
>   		goto out;
>   	}
>   
> -	supported = openat_tmpfile_supported(open_tree_fd);
> -
>   	pid = fork();
>   	if (pid < 0) {
>   		log_stderr("failure: fork");
> @@ -3849,6 +3847,8 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
>   		if (!switch_ids(10000, 11000))
>   			die("failure: switch fsids");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		/* create regular file via open() */
>   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>   		if (file1_fd < 0)
> @@ -4014,8 +4014,6 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>   		goto out;
>   	}
>   
> -	supported = openat_tmpfile_supported(open_tree_fd);
> -
>   	pid = fork();
>   	if (pid < 0) {
>   		log_stderr("failure: fork");
> @@ -4025,6 +4023,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>   		if (!switch_userns(attr.userns_fd, 0, 0, false))
>   			die("failure: switch_userns");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		/* create regular file via open() */
>   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>   		if (file1_fd < 0)
> @@ -4133,6 +4133,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>   		if (!switch_userns(attr.userns_fd, 0, 0, false))
>   			die("failure: switch_userns");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		if (!caps_down_fsetid())
>   			die("failure: caps_down_fsetid");
>   
> @@ -4257,6 +4259,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
>   		if (!switch_userns(attr.userns_fd, 0, 1000, false))
>   			die("failure: switch_userns");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		if (!caps_down_fsetid())
>   			die("failure: caps_down_fsetid");
>   
> @@ -7733,8 +7737,6 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
>   		goto out;
>   	}
>   
> -	supported = openat_tmpfile_supported(open_tree_fd);
> -
>   	pid = fork();
>   	if (pid < 0) {
>   		log_stderr("failure: fork");
> @@ -7752,6 +7754,8 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
>   		if (!switch_ids(10000, 11000))
>   			die("failure: switch fsids");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		/* create regular file via open() */
>   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>   		if (file1_fd < 0)
> @@ -7947,8 +7951,6 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
>   		goto out;
>   	}
>   
> -	supported = openat_tmpfile_supported(open_tree_fd);
> -
>   	/*
>   	 * Below we verify that setgid inheritance for a newly created file or
>   	 * directory works correctly. As part of this we need to verify that
> @@ -7984,6 +7986,8 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
>   		if (!switch_userns(attr.userns_fd, 0, 0, false))
>   			die("failure: switch_userns");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		if (!caps_down_fsetid())
>   			die("failure: caps_down_fsetid");
>   
> @@ -8181,8 +8185,6 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
>   		goto out;
>   	}
>   
> -	supported = openat_tmpfile_supported(open_tree_fd);
> -
>   	pid = fork();
>   	if (pid < 0) {
>   		log_stderr("failure: fork");
> @@ -8207,6 +8209,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
>   		if (!switch_ids(10000, 11000))
>   			die("failure: switch fsids");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		/* create regular file via open() */
>   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>   		if (file1_fd < 0)
> @@ -8342,6 +8346,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
>   		if (!switch_ids(10000, 11000))
>   			die("failure: switch fsids");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		/* create regular file via open() */
>   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>   		if (file1_fd < 0)
> @@ -8536,8 +8542,6 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
>   		goto out;
>   	}
>   
> -	supported = openat_tmpfile_supported(open_tree_fd);
> -
>   	/*
>   	 * Below we verify that setgid inheritance for a newly created file or
>   	 * directory works correctly. As part of this we need to verify that
> @@ -8580,6 +8584,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
>   		if (!switch_userns(attr.userns_fd, 0, 0, false))
>   			die("failure: switch_userns");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		if (!caps_down_fsetid())
>   			die("failure: caps_down_fsetid");
>   
> @@ -8723,6 +8729,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
>   		if (!switch_userns(attr.userns_fd, 0, 0, false))
>   			die("failure: switch_userns");
>   
> +		supported = openat_tmpfile_supported(open_tree_fd);
> +
>   		if (!caps_down_fsetid())
>   			die("failure: caps_down_fsetid");
>   

