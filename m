Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667D81ACA
	for <fstests@vger.kernel.org>; Wed, 22 May 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377656; cv=none; b=IvDoP/Qi2+mDFA620fNOiI23qmsxbwYhzn0VqzHWl0hIPwIN4/oDNf6NAHA0wTu6Ezjr75Xy7lpWxudUfJwafHdYXxENDkcFqVNi0GzSk8kuXFok3PT78t4APA6Kyrt6ry6j54fOnbbZ/sb8Fpn2eOOXpogI4rOIoXCFP9KfH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377656; c=relaxed/simple;
	bh=NfVZmv6HXwa09F2oJKEOXUVTF58lSd5K2m7vizrKfg8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NhJDboyExZJidmBGBdlJq1TvxiX7+CDttuHRJaS1+n58isqJLnIVJmgBMY3Dt6Pg6qGytUcUdHxYuHqckrnVelEe2IlY+UFJRE5ZaqGlYcFNOR4zyWObgco1F8HMKUuIyIPIkmQ8FLfv4u5k2tlGx0sK41a2KSwU42PmslsCxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3zrzmU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3zrzmU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EB1C2BD11
	for <fstests@vger.kernel.org>; Wed, 22 May 2024 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716377656;
	bh=NfVZmv6HXwa09F2oJKEOXUVTF58lSd5K2m7vizrKfg8=;
	h=From:To:Subject:Date:From;
	b=D3zrzmU99TOZevgQz5xlz+XniUL3/nd/vBHjMIBt4Edl0StQtSBfHgI7ccuBFFgzX
	 jwEQ4z4mnO+AtZCYjnfYVEHQKTWfyQHkve4BbDyATBzLGF1ETVOV6QYgN0dER6NGFR
	 WgX7FBKNK5Q3r9hCgo6WxQ8XXDt6xj7TAmyfTaooYOy+Gf3I6Jbh+xpcxWJyPtWXRu
	 el1Cz5SVzqMLvBlQQrkGByUivawBif3BaNWd6dbkQQwsgzt3uy3YSghf2Kdrl5u/00
	 uInW90q7tGpo9uFP2iWPw3xFObjCCRuh9N7KCEvVfZQWZ9HNj3dBoaGGZwClxkl868
	 WHK+21KWwXQSA==
From: cem@kernel.org
To: fstests@vger.kernel.org
Subject: [PATCH] Log kernel version in check.log
Date: Wed, 22 May 2024 13:33:38 +0200
Message-ID: <20240522113408.392468-1-cem@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

After collecting several xfstests runs, it's useful to keep track on
which kernel a specific run happened.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index c6dba89b..7703c128 100755
--- a/check
+++ b/check
@@ -478,6 +478,7 @@ _wrapup()
 		fi
 
 		_global_log ""
+		_global_log "Kernel version: $(uname -r)"
 		_global_log "$(date)"
 
 		echo "SECTION       -- $section" >>$tmp.summary
-- 
2.45.1

