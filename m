Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701176;
	b=GT2tELMfVhlew6K6dJtDetZCWM3Rk4r2GTa2VzMHUh3zLY1sz7F2+QnrzAzlFksojOKh
	 aHINZAgZvOBK4cifnZ/KmC4jfaexSgXAH/Q0lx4D9BlB4rCplo1hJO3ZiJgpPwysDNRne
	 NpF1UskFz/jQEo178cCa3fREpWhezI+gQq6VqNLQcMIM+9O8w/dRbQsJKhf5nyGzzwzza
	 lYMXzI94Po220bzNnkqJqCPgdNmh9AiEao7nkA9A/9AJVwyzd+ftIYh6VGy8AvGdHnzm7
	 20dSV2vuygo9HSF/VUgQtHwQS0ZdbyO91OIX9Oln7fC8qwpWoaypyJDrq7T5IZ9kBoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701176;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=mw9GpZvUiuqPUiH8YRZ9i61cwLVcMv3dGCbQFhJEbuc=;
	b=A+Kh4W8TaXce5f2PrPX6KjjT/ofab3qsCGlROcDLAj5nPNJ26tuPA89PdUHcJdJbUu6Q
	 YaKUU5RFdnrSxDKRYddh3ApwV/leWk5/ZfBiIM01MgIPc8XtaO8enEiiK0ly2iLrVaMu3
	 fU/hMkkVJNyCabCyzOV2jb4LeyiMcazmbcK5/s61UiBvee+QD9XsnkmIrf2KFPzU9VyKi
	 QmFPUOMR/tK99ImzX0D1p6abO/lyj59kScmp6SenHSQhO5VPc7WQKbz73ttUZgOtXxHYk
	 Dj+SnKjqsgyAsYU7AgMZbLFagJe33sDxCECAIxYMZArclV2rl4Ru5/SJbdcjIzo4l8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JeBgxfeU;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z0Y8TMJF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JeBgxfeU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z0Y8TMJF;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA54606A813
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 10:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA54606A813
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JeBgxfeU;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z0Y8TMJF;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JeBgxfeU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z0Y8TMJF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1424F1F8BE;
	Tue,  3 Nov 2026 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793701174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw9GpZvUiuqPUiH8YRZ9i61cwLVcMv3dGCbQFhJEbuc=;
	b=JeBgxfeUIee+Ghz67xNf81Lv1GmSSVM3Cx8DztwX1EFFFnF2uLAQdhpx/UWMrLHVw7EO2g
	WKWqF6xtTo7/uKy69LF68TCSaldY7bIxNN0HphsX6XzRNXpRdfteRj2JLP7CEommf1w26w
	dV8922ZpURH882dgZjFE942MsI49RkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793701174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw9GpZvUiuqPUiH8YRZ9i61cwLVcMv3dGCbQFhJEbuc=;
	b=Z0Y8TMJF/EHqbsOLJsbOKok0Vr2mbPcEZ2At1hfo4x4XckWOjT+PbFfbeFhp0iepjDuq26
	sBizj/N/zoFzdBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793701174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw9GpZvUiuqPUiH8YRZ9i61cwLVcMv3dGCbQFhJEbuc=;
	b=JeBgxfeUIee+Ghz67xNf81Lv1GmSSVM3Cx8DztwX1EFFFnF2uLAQdhpx/UWMrLHVw7EO2g
	WKWqF6xtTo7/uKy69LF68TCSaldY7bIxNN0HphsX6XzRNXpRdfteRj2JLP7CEommf1w26w
	dV8922ZpURH882dgZjFE942MsI49RkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793701174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw9GpZvUiuqPUiH8YRZ9i61cwLVcMv3dGCbQFhJEbuc=;
	b=Z0Y8TMJF/EHqbsOLJsbOKok0Vr2mbPcEZ2At1hfo4x4XckWOjT+PbFfbeFhp0iepjDuq26
	sBizj/N/zoFzdBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDFCC1350A;
	Tue,  3 Nov 2026 10:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id awBgLjW16WqGewAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 10:19:33 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 671BBB203; Tue, 03 Nov 2026 11:19:29 +0100 (CET)
Date: Tue, 3 Nov 2026 11:19:29 +0100
From: Jan Kara <jack@suse.cz>
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: test reserved GID block allocation
Message-ID: <j2dthue3fzup753jrndn6kh44qfvihx2bylmiwcoxubnrxpgdk@zx6shyx3hbb6>
References: <20261012112109.3363168-1-sahaj123.sc@gmail.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012112109.3363168-1-sahaj123.sc@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 12-10-26 16:51:09, Sahaj Chaudhari wrote:
> Add an xfstests regression test that exhausts ordinary free space, then
> checks that a process using ext4's reserved GID can allocate a block.
> 
> Link: https://lore.kernel.org/r/20261008065651.3517824-1-sahaj123.sc@gmail.com
> Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>

Thanks for the test! Just when seeing this, it seems you can achieve the
same with just "su -g" and xfs_io instead of having to write your test
program in C. That way it would be much more obvious what it's doing...

								Honza

> ---
>  .gitignore          |   1 +
>  src/Makefile        |   1 +
>  src/t_ext4_resgid.c | 207 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/309      |  43 +++++++++
>  tests/ext4/309.out  |   2 +
>  5 files changed, 254 insertions(+)
>  create mode 100644 src/t_ext4_resgid.c
>  create mode 100755 tests/ext4/309
>  create mode 100644 tests/ext4/309.out
> 
> diff --git a/.gitignore b/.gitignore
> index d52ba4ad..9baf0aa4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -149,6 +149,7 @@ tags
>  /src/t_enospc
>  /src/t_ext4_dax_inline_corruption
>  /src/t_ext4_dax_journal_corruption
> +/src/t_ext4_resgid
>  /src/t_futimens
>  /src/t_get_file_time
>  /src/t_getcwd
> diff --git a/src/Makefile b/src/Makefile
> index 0ff607ae..aba5da1e 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -16,6 +16,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	holetest af_unix t_mmap_stale_pmd \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> +	t_ext4_resgid \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> diff --git a/src/t_ext4_resgid.c b/src/t_ext4_resgid.c
> new file mode 100644
> index 00000000..3085a06a
> --- /dev/null
> +++ b/src/t_ext4_resgid.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <grp.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#define TEST_UID 1000
> +#define FILL_GID 1001
> +#define RESGID 456
> +#define TEST_BLOCK_SIZE 4096
> +#define MAX_BLOCKS 32768
> +#define TEST_SKIP 77
> +
> +struct worker_result {
> +	off_t offset;
> +	int error;
> +	int setup_error;
> +};
> +
> +static int report_error(const char *message, int error)
> +{
> +	fprintf(stderr, "%s: %s\n", message, strerror(error));
> +	return 1;
> +}
> +
> +static void worker(int fd, gid_t gid, bool fill, off_t offset, int pipefd)
> +{
> +	struct worker_result result = {
> +		.offset = offset,
> +	};
> +	ssize_t n;
> +	int i;
> +
> +	if (setgroups(0, NULL) || setresgid(gid, gid, gid) ||
> +	    setresuid(TEST_UID, TEST_UID, TEST_UID)) {
> +		result.setup_error = errno;
> +		goto report;
> +	}
> +
> +	if (fill) {
> +		for (i = 0; i < MAX_BLOCKS; i++) {
> +			if (fallocate(fd, 0, result.offset, TEST_BLOCK_SIZE)) {
> +				result.error = errno;
> +				goto report;
> +			}
> +			result.offset += TEST_BLOCK_SIZE;
> +		}
> +		result.error = EFBIG;
> +	} else if (fallocate(fd, 0, result.offset, TEST_BLOCK_SIZE)) {
> +		result.error = errno;
> +	}
> +
> +report:
> +	do {
> +		n = write(pipefd, &result, sizeof(result));
> +	} while (n < 0 && errno == EINTR);
> +	if (n != sizeof(result))
> +		_exit(1);
> +	_exit(0);
> +}
> +
> +static int read_result(int fd, struct worker_result *result)
> +{
> +	char *data = (char *)result;
> +	size_t remaining = sizeof(*result);
> +
> +	while (remaining) {
> +		ssize_t n = read(fd, data, remaining);
> +
> +		if (n < 0 && errno == EINTR)
> +			continue;
> +		if (n < 0)
> +			return -errno;
> +		if (!n)
> +			return -EIO;
> +		data += n;
> +		remaining -= n;
> +	}
> +
> +	return 0;
> +}
> +
> +static int run_worker(int fd, gid_t gid, bool fill, off_t offset,
> +		      struct worker_result *result)
> +{
> +	int pipefd[2], status, ret;
> +	pid_t pid, waited;
> +
> +	if (pipe(pipefd))
> +		return -errno;
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		ret = -errno;
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		return ret;
> +	}
> +	if (!pid) {
> +		close(pipefd[0]);
> +		worker(fd, gid, fill, offset, pipefd[1]);
> +	}
> +
> +	close(pipefd[1]);
> +	ret = read_result(pipefd[0], result);
> +	close(pipefd[0]);
> +
> +	do {
> +		waited = waitpid(pid, &status, 0);
> +	} while (waited < 0 && errno == EINTR);
> +	if (waited < 0)
> +		return -errno;
> +	if (waited != pid || !WIFEXITED(status) || WEXITSTATUS(status))
> +		return -EIO;
> +
> +	return ret;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	char filename[PATH_MAX];
> +	struct worker_result fill_result, group_result;
> +	int fd = -1, ret = 1, result;
> +	bool created = false;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "usage: %s mountpoint\n", argv[0]);
> +		return 2;
> +	}
> +	result = snprintf(filename, sizeof(filename), "%s/ext4_resgid.fill",
> +			  argv[1]);
> +	if (result < 0 || (size_t)result >= sizeof(filename)) {
> +		fprintf(stderr, "mountpoint path is too long\n");
> +		return 2;
> +	}
> +
> +	fd = open(filename, O_CREAT | O_EXCL | O_RDWR, 0666);
> +	if (fd < 0)
> +		return report_error("creating test file", errno);
> +	created = true;
> +
> +	if (fchown(fd, TEST_UID, FILL_GID))
> +		goto fail_file;
> +	if (fchmod(fd, 0666))
> +		goto fail_file;
> +
> +	result = run_worker(fd, FILL_GID, true, 0, &fill_result);
> +	if (result)
> +		goto fail_worker;
> +	if (fill_result.setup_error) {
> +		fprintf(stderr, "dropping fill-worker credentials: %s\n",
> +			strerror(fill_result.setup_error));
> +		ret = fill_result.setup_error == EPERM ? TEST_SKIP : 1;
> +		goto out;
> +	}
> +	if (fill_result.error != ENOSPC) {
> +		fprintf(stderr, "unprivileged fill stopped with %s, expected ENOSPC\n",
> +			strerror(fill_result.error));
> +		goto out;
> +	}
> +
> +	result = run_worker(fd, RESGID, false, fill_result.offset, &group_result);
> +	if (result)
> +		goto fail_worker;
> +	if (group_result.setup_error) {
> +		fprintf(stderr, "setting reserved-GID credentials: %s\n",
> +			strerror(group_result.setup_error));
> +		ret = group_result.setup_error == EPERM ? TEST_SKIP : 1;
> +		goto out;
> +	}
> +	if (group_result.error) {
> +		fprintf(stderr, "reserved-GID allocation failed: %s\n",
> +			strerror(group_result.error));
> +		goto out;
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +fail_file:
> +	ret = report_error("setting test-file owner and mode", errno);
> +	goto out;
> +fail_worker:
> +	ret = report_error("running allocation worker", -result);
> +out:
> +	if (fd >= 0 && close(fd)) {
> +		fprintf(stderr, "closing test file: %s\n", strerror(errno));
> +		ret = 1;
> +	}
> +	if (created && unlink(filename)) {
> +		fprintf(stderr, "removing test file: %s\n", strerror(errno));
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}
> diff --git a/tests/ext4/309 b/tests/ext4/309
> new file mode 100755
> index 00000000..0702a3dd
> --- /dev/null
> +++ b/tests/ext4/309
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Sahaj Chaudhari.  All Rights Reserved.
> +#
> +# FS QA Test No. 309
> +#
> +# Verify that the ext4 reserved GID can allocate blocks after ordinary
> +# free space is exhausted.
> +#
> +. ./common/preamble
> +_begin_fstest auto enospc quick
> +
> +_exclude_fs ext2
> +_exclude_fs ext3
> +_exclude_scratch_mount_option "resuid=" "resgid="
> +
> +_fixed_by_kernel_commit c87abbab6147 \
> +	"ext4: fix incorrect function call when initializing s_resgid"
> +
> +_require_scratch
> +_require_command "$TUNE2FS_PROG" tune2fs
> +_require_test_program "t_ext4_resgid"
> +
> +echo "Silence is golden"
> +
> +MKFS_OPTIONS="-m 10 -N 1024 -O ^has_journal $MKFS_OPTIONS" \
> +	_scratch_mkfs_sized $((16 * 1024 * 1024)) 4096 >>"$seqres".full 2>&1
> +"$TUNE2FS_PROG" -u 123 -g 456 "$SCRATCH_DEV" >>"$seqres".full 2>&1
> +_scratch_mount
> +
> +if "$here/src/t_ext4_resgid" "$SCRATCH_MNT" >>"$seqres".full 2>&1; then
> +	:
> +else
> +	ret=$?
> +	if [ "$ret" -eq 77 ]; then
> +		_notrun "cannot drop worker privileges"
> +	fi
> +	_fail "reserved-GID allocation test failed"
> +fi
> +
> +_scratch_unmount
> +status=0
> +exit
> diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> new file mode 100644
> index 00000000..56330d65
> --- /dev/null
> +++ b/tests/ext4/309.out
> @@ -0,0 +1,2 @@
> +QA output created by 309
> +Silence is golden
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
