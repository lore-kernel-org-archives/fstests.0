Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775627;
	b=unMktcAmUYo2N1wmhBU/2HPsdSDGGP+fRLfAwQojRQw+Re1MRTsVbW19LmT5bkkd/7db
	 FDTQVWFE5HV6qN7G5FlB9WiUm7FpU4OoNwOZCjNGExkRFL+GQCHW8B5D7FYdgy9/mjdTQ
	 0j5r0W8ZzLK/QrhNYjT1ew4qH+uDPlnGG5n9LQ+ed8BaxCr46L1lF+IRLEO80ts/hvwWA
	 E5NbyS2p6e/6XtOcU8SAHbaDv+KCirTn4Tx2WYBezfcuOvXsveyP1FNkgBObFyJeeUpxQ
	 Fl3NzU4HmqSC+VURFv/J/K2JQFvAt2qCAZoE+6XjhwvnckLYNooyA7ClRwBzdC6O+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775627;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VZ9oiZBR/gs80wyccTbtpY9QfxpNlTsccFMA8E+4LTY=;
	b=h2xAvh5QBocRoZ3dEbuxWbfFVJZ2ofMxlAhn87SPTtaCBMdIl7HWkckze0oJI6IvMKU4
	 j0Xp7T8GoYybRpRJmhEXtfdXKMM5GcXld5a2eSEI1v8+rT89OT8XgBR5Ttqoq5SlgNL1v
	 YIdJPGrvnr+lYii019FD4PcZr/T017xRjpe7c5a0E3g2tlRUQCNOaYiz4DKOkgol6yO+X
	 MzVQBvssv13QSEz0RoCPLOayCD1K4AsInkykYz94qglhQq7KqszgYPRpec/Hp6AhdYOFJ
	 zqvCfzBIzujeH2yW+w/QRW6a8d2wXPRf1Qxua6INunNoiyJOAV9PyVop2fRxbyhn9MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCyUyvTw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B7606A31B
	for <fstests@vger.kernel.org>; Wed,  4 Nov 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCyUyvTw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746181F000C1;
	Wed,  4 Nov 2026 07:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793775626;
	bh=VZ9oiZBR/gs80wyccTbtpY9QfxpNlTsccFMA8E+4LTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCyUyvTwQXIi08o8iARISAWAsFkMhnZmi9CyvzFA0EOwRELcdkDln+etLpvejhzD3
	 1hCETilI49i60IcBi2rX96NK4Vn8WMaelx8HG8Qm2Q0bVuOdlD71HF/HgRZlDpEnrr
	 l0qZg874+A6rNJ3GDaI5YN/ghgmCWC91Lwg/2BMzH8h2oGX7jhe8qnx5ctZcVcaIjp
	 qPKUY6fMKFkLgm0Ps2NWVLWJjv14ZQX/UQ42zuB05kLWxUF8mcKcyJdvhABZ8cOxfB
	 NkPeaXxTZvVE5tZ78p6sB1HHA5phFmN8wk1ebn4hpNyfqfbR0T5pPMhIMKR5Y4NdUQ
	 HpzmJ/poDUTVQ==
Date: Wed, 4 Nov 2026 15:00:19 +0800
From: Zorro Lang <zlang@kernel.org>
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: test reserved GID block allocation
Message-ID: <aurRSqrRkEfyp6M7@zlang-mailbox>
Mail-Followup-To: Sahaj Chaudhari <sahaj123.sc@gmail.com>, 
	fstests@vger.kernel.org, Jan Kara <jack@suse.cz>
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

On Mon, Oct 12, 2026 at 04:51:09PM +0530, Sahaj Chaudhari wrote:
> Add an xfstests regression test that exhausts ordinary free space, then
> checks that a process using ext4's reserved GID can allocate a block.
> 
> Link: https://lore.kernel.org/r/20261008065651.3517824-1-sahaj123.sc@gmail.com
> Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
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

I had a quick look at the C program. As Jan pointed out, it should be possible
to replace it with pure bash commands, something like below (just a rough
draft for reference):

_require_user
...

RESGID=456
TEST_FILE="$SCRATCH_MNT/testfile"
touch "$TEST_FILE"
chmod 0666 "$TEST_FILE"

_user_do "$XFS_IO_PROG -c 'pwrite 0 16M' '$TEST_FILE'" > /dev/null 2>&1
_user_do "$XFS_IO_PROG -c 'falloc 16M 4k' '$TEST_FILE'" >>"$seqres".full 2>&1 && \
	_fail "ordinary user should have gotten ENOSPC"
su $qa_user -g $RESGID -c "$XFS_IO_PROG -c 'falloc 16M 4k' '$TEST_FILE'" >>"$seqres".full 2>&1 || \
    _fail "reserved GID failed to allocate block from reserved pool"

(Maybe we could extend _user_do to accept a -g option)

Thanks,
Zorro

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
> 
