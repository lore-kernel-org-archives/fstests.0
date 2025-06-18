Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425EF2E719D;
	Wed, 18 Jun 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251621; cv=none; b=HOFEI5YK/XMcjhQA7WPie8xjQXyo5oRypRCZl9cGficXTzFYPPfnI3hqb5Rki+DRvgze1ChGH08eZkRZnf/uwwH0IizzMi8b0EXLOQj4nqi/RvKMDG3dfjar9Q7vZIzT1cFZ2ox/OwNGPKi9fL/MvRzIFbSQREH3Te8Qhk1Mg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251621; c=relaxed/simple;
	bh=USacO9OTdPr4qCz3iJ+RKMELFRIMSvBKG/O8EN/eqCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GRWOr3PJeZ8tLac2uAy8xJoxrP/c42v55D44s1nT5IxO+k3sXVr5Y3VxZDCiBw1pwouen/NSQIEumels6vK6v6E1b+1PqoeqQYE+KTD1MTRyEgX+rKCWhs57ElBMDiUOHWtET9FXrizHFBg00H/uLKsX8pbmv7FZa2qlAzIyDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvIJyf5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvIJyf5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F35CC4CEE7;
	Wed, 18 Jun 2025 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750251619;
	bh=USacO9OTdPr4qCz3iJ+RKMELFRIMSvBKG/O8EN/eqCE=;
	h=From:Date:Subject:To:Cc:From;
	b=tvIJyf5NahCGyy6QVon/RgyFFVKFMW23jEkKe4/u3t/aWpK4CIeUJB9wGKweHrUkj
	 XyQ6/usXWNVbkctv0b3H1gbTajXg9jlH8G6JSay6q2EFnfLmJ5sb6Zl93z/B3G8aik
	 7nCqdd9jDf4hBL/0XqJjozwQRIM+F9o+bcd/HS/TnRT/aR7RJjghc4uBDHNBvl4nzf
	 xrYZwYDqbGxG6k3yyk6o8NMbTQIWLoeia/OsEWx47c0Iowe8pxTDoCFRUs+tbYP6Zc
	 WVXt+p6Ilw9MA1msP1bP3dXHpmxzxa5axEfvKHLzqryk5YxcjYSNlK2joEZQnCq9my
	 8MmG4nivQ9h1w==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 18 Jun 2025 15:00:12 +0200
Subject: [PATCH] generic/551: prevent OOM when running on tmpfs with low
 memory
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-fix-tmpfs-generic-551-v1-1-271027c36dfc@samsung.com>
X-B4-Tracking: v=1; b=H4sIAFu4UmgC/x2MQQqAMAzAviI9W3BjVfEr4kFn1R6csokIsr9bP
 AaSvJA4Cifoihci35LkCAqmLMBvY1gZZVYGW1mqatPiIg9e+7kkXDlo65HIoPONmwzNzlsCbc/
 IKv7ffsj5A+IlxHRnAAAA
X-Change-ID: 20250618-fix-tmpfs-generic-551-4c74b15d4c25
To: fstests@vger.kernel.org, Hugh Dickins <hughd@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev, 
 Daniel Gomez <da.gomez@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 gost.dev@samsung.com, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4720; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=ojgdiifY9VvMiz2xw1FjEsGCEmrhfvJ7zzliXmLZE5w=;
 b=owEBbQKS/ZANAwAIAYX1bqTp6BOPAcsmYgBoUrhewUahjURdRBzEwLRlVXNjtU0DPgpLZrlXo
 iI/fCfYxdyJAjMEAAEIAB0WIQSyp6nP3QO1QP9YsnGF9W6k6egTjwUCaFK4XgAKCRCF9W6k6egT
 jyYSD/9oRGHHOCIquHEgwPXrGbt0tW/PkVfMby5sqaXJJ+yYfwqgX0nsImih77GAprwEUkTXUdW
 bp3Xz5snPaYA7yl3I9ts2V8a+UF2H40xRqBnS0pnMlHhspcNUvTS+4pSblAt0E8VvNFG9j+9hIe
 QSh2mTLAnlLahEC0TV5XPM/3iLUrpZNOe6QCGOqAJ6J9jKIGO/6MEPtWegndVbpf5L9FjUcCJYV
 01W527S2PgAh4zjS8ggG3MaAgJ2iDZI2pYuzRvugF/pr+FQaOdxGoAy7Un8eYieIg6hEfhYi/Hd
 nxqhKw2nkxgSPWPzTOydKOfmjakXyG7xLSTsnQuc86ikv6wPLXruKWASOZSks3PTDIxD8u8t/MJ
 x6f6sb8LfP/L3I994MLAuHtPxnyt/8UjPfbnkyCHyduQQYpJdy6LMrKMbbxJ6jNBCXPgWk81M3c
 LpiHkas66RHHXpn0D0kkCpgzz//evAY0FkKVVrSrDSwiv367hpQXAJFV70RS0ufg3xLkEovlFfH
 WJ9kT1Oof4pfd/1agC1urKv0ZU4HBYz7uUtA3SQ9SRk9eWI0Im0Q4t0uaRmOPDnpRsbn9WDqSRW
 0DByMelTuAeMA1ZyUTmftgHcE85dyWmIP5KAzSfuT92ri3lEedTEEfjQRADoeJSE/FlWEaWnnmn
 tQODd/rcIdLXmKg==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

From: Daniel Gomez <da.gomez@samsung.com>

Running generic/551 on a tmpfs filesystem with less than 10 GB (ish)
of RAM can lead to the system running out of memory, triggering the
kernel's OOM killer and terminating the aio-dio-write-v process.

Fix generic/551 by substracting the amount of available memory allocated
for the tmpfs scratch device to the total available free memory.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
While integrating tmpfs support for xfstests in kdevops CI [1], we noticed
that generic/551 could trigger the OOM killer when the scratch device
is tmpfs, due to not properly accounting for available system memory.
Fix the test for tmpfs by subtracting the memory allocated to the
scratch tmpfs mount from the total available memory, ensuring the test
runs within safe limits.

[1]
https://lore.kernel.org/all/20250615-ci-workflow-v1-0-53b267cd2f0a@samsung.com/

These are the kernel oom-killer logs for generic/551 run on a system
with less than 10G of RAM:

run fstests generic/551 at 2025-06-18 11:42:44
aio-dio-write-v invoked oom-killer:
gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0,
oom_score_adj=250
CPU: 5 UID: 0 PID: 1717 Comm: aio-dio-write-v Not tainted
6.16.0-rc2-00049-g52da431bf03b #10 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2025.02-6
04/08/2025
{...}
Tasks state (memory values in pages):
[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem
pgtables_bytes swapents oom_score_adj name
{...}
[   1717]     0  1717   876600   875978   875945       33         0
7065600        0           250 aio-dio-write-v
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowe
d=0,global_oom,task_memcg=/system.slice/fstests-generic-551.scope,task=a
io-dio-write-v,pid=1717,uid=0
Out of memory: Killed process 1717 (aio-dio-write-v) total-vm:3506400kB,
anon-rss:3503780kB, file-rss:132kB, shmem-rss:0kB, UID:0 pgtables:6900kB
oom_score_adj:250

Results collected with kdevops on the following tmpfs profiles
(before/after the changes):

diff --git a/workflows/fstests/results/last-run/
6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
b/workflows/fstests/results/last-run/
6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
index 02a1f09..0229294 100644
--- a/workflows/fstests/results/last-run/
6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
+++ b/workflows/fstests/results/last-run/
6.16.0-rc2-00049-g52da431bf03b/xunit_results.txt
@@ -1,21 +1,21 @@
 KERNEL:    6.16.0-rc2-00049-g52da431bf03b
 CPUS:      8

-tmpfs_noswap_huge_never: 1 tests, 1 failures, 9 seconds
-  generic/551  Failed   8s
-tmpfs_default: 1 tests, 1 failures, 5 seconds
-  generic/551  Failed   4s
-tmpfs_noswap_huge_within_size: 1 tests, 1 failures, 8 seconds
-  generic/551  Failed   8s
-tmpfs_huge_always: 1 tests, 1 failures, 11 seconds
-  generic/551  Failed   11s
-tmpfs_huge_within_size: 1 tests, 1 failures, 8 seconds
-  generic/551  Failed   8s
-tmpfs_noswap_huge_always: 1 tests, 1 failures, 6 seconds
-  generic/551  Failed   6s
-tmpfs_noswap_huge_advise: 1 tests, 1 failures, 8 seconds
-  generic/551  Failed   7s
-tmpfs_huge_advise: 1 tests, 1 failures, 8 seconds
-  generic/551  Failed   7s
-Totals: 8 tests, 0 skipped, 8 failures, 0 errors, 59s
+tmpfs_noswap_huge_advise: 1 tests, 134 seconds
+  generic/551  Pass     134s
+tmpfs_noswap_huge_never: 1 tests, 141 seconds
+  generic/551  Pass     141s
+tmpfs_huge_advise: 1 tests, 142 seconds
+  generic/551  Pass     142s
+tmpfs_default: 1 tests, 139 seconds
+  generic/551  Pass     139s
+tmpfs_noswap_huge_always: 1 tests, 109 seconds
+  generic/551  Pass     108s
+tmpfs_noswap_huge_within_size: 1 tests, 116 seconds
+  generic/551  Pass     115s
+tmpfs_huge_within_size: 1 tests, 112 seconds
+  generic/551  Pass     111s
+tmpfs_huge_always: 1 tests, 145 seconds
+  generic/551  Pass     145s
+Totals: 8 tests, 0 skipped, 0 failures, 0 errors, 1035s
---
 tests/generic/551 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/551 b/tests/generic/551
index 4a7f0a638235e272ef55ffeb3b3e548707568379..6a7376d7a8e3580bee0a5c98eacdaf93c60c8d5c 100755
--- a/tests/generic/551
+++ b/tests/generic/551
@@ -38,6 +38,7 @@ do_test()
 	local truncsize
 	local total_size=0
 	local avail_mem=`_available_memory_bytes`
+	[ "$FSTYP" = "tmpfs" ] && avail_mem=$((avail_mem - free_size_k * 1024))
 
 	# the number of AIO write operation
 	num_oper=$((RANDOM % 64 + 1))

---
base-commit: b7680adf9ff7bdc962fb95b5cbd304abd3137b69
change-id: 20250618-fix-tmpfs-generic-551-4c74b15d4c25

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>

