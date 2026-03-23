Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA01A38F9
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272738; cv=none; b=lJj3JTa1Hc7lxRK38VGbRUXunjNFG9FEGq2SAvV/YxUMSKXZszgKLBDPzNqJffCslpj3igJ6yxDsuS/6eBHDI43Lqjn1ddWDVgZoeQ/s0tzcOkwipTRLDrok2pVoKecdEuCE9T1B8Hlp5PD/xdTtVeJ/3xEukWSpE5cRYeVLTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272738; c=relaxed/simple;
	bh=Jpdndc/lz9TCArPCQTh2MHRK0i1Yyia6el5LSNGkhOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VjOiIvLlL36JqQxVTwxl+8/dAHt2fzePd3o6YCQTqywx7P3WFZWt8XEhK/cVb8dbGjN5eWmzqJhIckFEu4pa6k6C680FZXtrzs4sAFZ893YBgb6IPkiomY1y229GcO4H5z59lx9sZhEeSwdMVeZe5Kzt/eAMcjbcNrIFbW5buzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIaZLX54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIaZLX54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBD7C4CEF7;
	Mon, 23 Mar 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774272738;
	bh=Jpdndc/lz9TCArPCQTh2MHRK0i1Yyia6el5LSNGkhOI=;
	h=From:Date:Subject:To:Cc:From;
	b=eIaZLX545sZ7qQgWbokhN9vldc/AiZchxUwH0x1y2IgjgdbqmZop2GJhW3VN6tSq7
	 xIf1rKlmCQHYHhFrl+C/NGrgKQotLGruVkMMNJojc/syOSKoMPoE7rA+nXIsE9WX46
	 iaLjc87bMu1WhBpEg3l628n0X9INQx7wbDOcP2v7dT4IPhVw+K/gjctQWSQEK6YNg9
	 sAPwtjbbfFfFM/E3G4xrl8RAXaiGyMPQGkePilbDpPfe5zsP+a2g2NHCEiisF4I5xO
	 HdCoo6QN40ZlJfOn8rndYqC9fZKPhvJzyiCg03yq1wtk+DxAhDex2qGWItOSPL+FFJ
	 FgGK2zTqtPX+g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Mar 2026 14:32:15 +0100
Subject: [PATCH] vfs: fix dumpable race in create_userns_hierarchy()
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fix-vfs-bugs-v1-1-76a6aed624d9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN5AwWkC/yWMywqDQAxFf0WybsCOYm1/pbiYR0bjYiyJiiD+e
 2fazYVzXycoCZPCqzpBaGflJWW43yrwk00jIYfMYGrT1Y1pMPKBe1R025iljb1tnyZ04QF58hH
 K+e/uPfxZNzeTX8tHaTirhE5s8lOx4iKY6Fjhur6mJ+RFiwAAAA==
X-Change-ID: 20260323-fix-vfs-bugs-b4f8a492d6d7
To: fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Jpdndc/lz9TCArPCQTh2MHRK0i1Yyia6el5LSNGkhOI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQedHhoJsPHzxKSbGa4Z92tOSe9rLdYbbFZ1ySzXoTlk
 wtHteXOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8fM7IcP1aT/XEJEaPed3H
 hM5kHV6wUzfs85c12RFa/CKtTN/fXWT4yZiqPs9qeu3DfRo9qubeIlsqzq35/k1+xsEl2xU//Kp
 WZgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

All processes in the userns hierarchy share the same mm_struct due to
CLONE_VM. When a child calls setresuid() in switch_ids(), the kernel
clears the dumpable flag on the shared mm. The child immediately
re-sets it via prctl(PR_SET_DUMPABLE, 1), but there is a window
between the two where the parent may be opening /proc/PID/ns/user for
the previous level's child. That open hits ptrace_may_access() which
checks get_dumpable(mm) and, finding it zero, falls back to
ptrace_has_cap(mm->user_ns, mode). Since mm->user_ns is init_user_ns
(the mm was created by real root) and the parent is only ns-root, the
capability check fails and the open returns -EACCES.

Fix this by extending the existing two-way socketpair handshake into a
three-way handshake: the child signals the parent after becoming
dumpable, then blocks until the parent has opened /proc/PID/ns/user
and signals back. Only then does the child proceed to
create_userns_hierarchy() for the next level. This guarantees no
concurrent setresuid() can clear dumpable while the parent's open() is
in flight.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/utils.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 52bb7e42..0b435afe 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -312,6 +312,18 @@ static int userns_fd_cb(void *data)
 	if (ret < 0)
 		return syserror("failure: write to socketpair");
 
+	/*
+	 * Wait for the parent to open our /proc/PID/ns/user before
+	 * proceeding to create the next userns level. Without this,
+	 * setresuid() in the next-level child clears the dumpable flag
+	 * on the shared mm (CLONE_VM) and the parent's open() fails the
+	 * ptrace_may_access() check with -EACCES because mm->user_ns is
+	 * init_user_ns where userns processes lack CAP_SYS_PTRACE.
+	 */
+	ret = read_nointr(h->fd_event, &c, 1);
+	if (ret < 0)
+		return syserror("failure: read from socketpair");
+
 	ret = create_userns_hierarchy(++h);
 	if (ret < 0)
 		return syserror("failure: userns level %d", h->level);
@@ -377,6 +389,14 @@ int create_userns_hierarchy(struct userns_hierarchy *h)
 		goto out_wait;
 	}
 
+	/* Tell the child it can now proceed to create the next level. */
+	bytes = write_nointr(fd_socket[0], "1", 1);
+	if (bytes < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: write to socketpair");
+		goto out_wait;
+	}
+
 	fret = 0;
 
 out_wait:

---
base-commit: 3ded3e13c008326d197d11ac975049ed1f8ec922
change-id: 20260323-fix-vfs-bugs-b4f8a492d6d7

