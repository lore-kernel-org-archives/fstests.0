Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800245000
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616824; cv=none; b=EVPMk6kiXyWcL0rtI25XNfpiLQMNKGN6xINNySw5uTAREV5jhAV4W/JfJJthP065h9J9bjPzXHJXwd5/UvwjFOas1nrTX3rg9jG2K5R/0n1elnx7nJnCdrKkHHVj46HpsD7aDQAfAdPFXm5nz3vs07NO4GsitrHUnGGjrNRmiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616824; c=relaxed/simple;
	bh=PqzyJYAjIHRKhj/lv/kshE+KTvFGUk/TwKigm1qO8Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDVTdTXJEZU8GoeJDTIJrQaUvOCrmfOBFBm0nlpbRsoDY61hFkCjjBLBkBCn13W1eJki7Gpt7pDjlaKUJd0g+wYaUfRHKa6of+UEa0e27+Rhsgqt7PFNUC+yRJmV+TBKDO/nWm52ZDoNNuVWOPbG7rKsluvbab6Wxnqrtao9Yvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEPFTXre; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUVSfbVt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEPFTXre";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUVSfbVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787616822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlUfgIQ4toNL9nkcfUZLNWskHwK6+zZVge0k4I6Unog=;
	b=cEPFTXrekgsdYO2Y4PtJwW9aXw8RCKDLZeQavmcik4+SBq3avoaQhEZSJoeGR77A2K1Wab
	cYf3mkzfb4X9jmmqxHjRbZOYa3NMJl4yxFxdrXWFMTM6yhp+b1D5OgeWMj7McpKxn/yxGg
	WWpuySEJI/awfWeTf4919MtFeuDZ4mE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-AgwPZ8hfOPmhNF_ZW2lJFw-1; Mon, 24 Aug 2026 20:13:41 -0400
X-MC-Unique: AgwPZ8hfOPmhNF_ZW2lJFw-1
X-Mimecast-MFC-AGG-ID: AgwPZ8hfOPmhNF_ZW2lJFw_1787616820
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9ee20bde0so9336206a34.2
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787616820; x=1788221620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlUfgIQ4toNL9nkcfUZLNWskHwK6+zZVge0k4I6Unog=;
        b=AUVSfbVtrl9QRxiScilhJpfgFE0lL7+tkEGWMOAynzWaxkxFIwTG0y+yPS1nKvoXPQ
         g5c5NSBPAWnzqUukxPJD+ghgfRfn6pbpWVixLnVOmSs8zbQeExcjzKlQwZ6srWCfvDZ/
         R80WJDLEfdB2axd1H7uOwwL/Ue7AZSr7XFowP8pnGEo9YLlxUvN+l1gRq8y5lO2w5NOh
         ioYGpKzGOqY1p23npa4+Y7SZlj8h8Q2FhuX1Z/0vO0HOU8F3RYObj8aGoX9bTL7YNDsW
         2uK7EH1wPCWAsVQfIqkC5WPS5bOW/N/fc5H9dtVQwXJ1szBswEFM9cc+q6g8sDmPA3ML
         jTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616820; x=1788221620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlUfgIQ4toNL9nkcfUZLNWskHwK6+zZVge0k4I6Unog=;
        b=ebOzerKgJ2FgPnQpwo/+e1eAK7GsFZbKO6Gn5kfXLyJEMvhxIJCKOWvU6GTStv7AMZ
         5Kwr6v9kv7RP8SvAXyPk5X2AOZapBQkcJ46+p/a7+hdahmuQmo53WReRYPJFYSAXtbgL
         TIktnuzr85j/l55NDUWLXIPHfXeBUQuNdBCmehYHOZTMLEaxCeADHsVlL12H5dkmoxhg
         JMjWNU85Jf86AzENH16UhyciEowKj96nawoiqcCNjsTvHkERJj8u9uJYZfr3pyNmhfEF
         aqdJoG2H/+YCJ/q94GBA2/jUghckt2gUk+9pyD+5EV5uaK+h56nIy7B0e6i+LiDdfK7B
         3Fgg==
X-Gm-Message-State: AFuF++kUV0lgmIKUG1LAlMWyNjLQsG+xVimYWiC5rl3XdNggKKV8Z8+D
	8gGOLzA4nDKAbFT5VQXJ1p60C1om1KFdYZGOT8RvgPI1EgVr3IhQqwg2K13CRA8P/qNjqhid5qd
	NZKy1DbOXm0qCupO1GOxAx61/fZ9eIVIyfoj7yhmyIilfVfdHlSveNbPsbJxMnAxMtU9+EPXAlB
	VfmIzFZd3HnCdjTJYmE6v56Fyxw2jVaMN8xLT9kN4TMz3E
X-Gm-Gg: AR+sD10TMs/13lx1FkyfHXevEe1ectZ6enKLO8YSOoq1pXgAKdq95amhQE4dMYZqZIk
	keojTwskNn4T3CALfZOh7SMd9FkB3vkKQeSiWxwa6D/9tZshoEaU2+4MkcgUrpJVE5HOsqVJ+vE
	Yy9YNDLPamm5xhLDdkH55JUP0EBOXsiBh3JX4eUiSrBXzFFNHDGk0AISuBComgHQjJsa75hxC/M
	sERRu2VkYvh0LVi75v3Ef6YVMumiSTGqV6/AYC/1VPNUiHeKneJfRyx+MW2kQEr3QZnlDHQgUNS
	3PQjgYR5JSTZGJy1uwGSm/UYGtNyc3/vOMJ8JMkh2t0G4yW4YeTC8Sd6ZEIN307ZAx//V0dT6ck
	i55HxE9PMXdsqzTuu1Dzqm9imw2+VM2cjABt3lZZTA9k=
X-Received: by 2002:a05:6830:6404:b0:7e6:d384:459e with SMTP id 46e09a7af769-7f4613487b7mr35985417a34.3.1787616820465;
        Mon, 24 Aug 2026 17:13:40 -0700 (PDT)
X-Received: by 2002:a05:6830:6404:b0:7e6:d384:459e with SMTP id 46e09a7af769-7f4613487b7mr35985367a34.3.1787616819990;
        Mon, 24 Aug 2026 17:13:39 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm6433923a34.24.2026.08.24.17.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:13:39 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/5] generic: remove chmod of $seqres.full file
Date: Mon, 24 Aug 2026 19:11:08 -0500
Message-ID: <20260825001337.449670-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001337.449670-1-sandeen@redhat.com>
References: <20260825001337.449670-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This appears to be an historical artifact.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 tests/generic/379 | 3 ---
 tests/generic/384 | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tests/generic/379 b/tests/generic/379
index 4c7fc939..9e5889b9 100755
--- a/tests/generic/379
+++ b/tests/generic/379
@@ -22,9 +22,6 @@ _cleanup()
 }
 
 
-cp /dev/null $seqres.full
-chmod ugo+rwx $seqres.full
-
 _require_scratch
 _require_quota
 _require_xfs_quota_foreign
diff --git a/tests/generic/384 b/tests/generic/384
index f2344380..69fe3695 100755
--- a/tests/generic/384
+++ b/tests/generic/384
@@ -42,9 +42,6 @@ cat >$tmp.projid <<EOF
 test:1
 EOF
 
-cp /dev/null $seqres.full
-chmod a+rwx $seqres.full	# arbitrary users will write here
-
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
-- 
2.55.0

