Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976715F332
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804276; cv=none; b=lynWl5h6ioQPTsUITO3yWKF1YCRjXUfPbkzN9G0GQ2jVTp7ILsCE175KrF5X4KmlyNs0dlboKjY03gaR3cWtFmJ6nOh4AOW8Zep+8j9hWEndEFMQywfFVcC+BnnzoWGTDPLrLO4DlnelAj9HNV7R8NxweJoq1R88oaEiszGi/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804276; c=relaxed/simple;
	bh=TmBrlscPJHZ1ZEn5cr0gvJmhLKyy4IqY7SkDQcp0zgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5jyB6/ggYZ0H13neZNplPD/A1cn2vdRtFsSxkGOtbyZ+oOw0QLabPgw6tvWxRH7JhtbnwGvWh7DmfpVAq0RaU3wNlWieiZkcasQFrTgJdpb/LwHM76aLafcwSc/g4kKbChllkBy8pP+cGBYjR3gclSlJM5sy9T8RbWNIT9GFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwHRZ8kw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwHRZ8kw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwHRZ8kw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwHRZ8kw"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7EB9122160
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706804272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOCfqOJcbDUQGot/hRdVo3tHG76yu/+TRTTjMn0nywU=;
	b=AwHRZ8kw7YRfGpBjIyX6AcgRuYhbDoWzVqMuH7mDjp5psqFR63VdVCaJWHHf8TfEnRjabi
	9+sr/tUyNIjPR/EfvjHoATtA5pMuWBJEvbRG/mGP1nTm8umsooqLaMOQ4lAjZRcGD+mCx6
	1VVoqAUOgXn4qFC0MjBN96icY01dpuQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706804272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOCfqOJcbDUQGot/hRdVo3tHG76yu/+TRTTjMn0nywU=;
	b=AwHRZ8kw7YRfGpBjIyX6AcgRuYhbDoWzVqMuH7mDjp5psqFR63VdVCaJWHHf8TfEnRjabi
	9+sr/tUyNIjPR/EfvjHoATtA5pMuWBJEvbRG/mGP1nTm8umsooqLaMOQ4lAjZRcGD+mCx6
	1VVoqAUOgXn4qFC0MjBN96icY01dpuQ=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH 2/2] generic/682: update and fix-up golden output
Date: Thu,  1 Feb 2024 17:17:32 +0100
Message-ID: <20240201161732.6126-3-ailiop@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240201161732.6126-1-ailiop@suse.com>
References: <20240201161732.6126-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

coreutils v9.4 introduced a change in the error output of mv under
certain errno values via commit 3cb862ce5f10 ("mv: better diagnostic for
'mv dir x' failure"), which broke the golden output.

Update golden output to match the change, and further add an output
filter to avoid having the test fail on environments that ran with an
older coreutils release, taken from commit d9323ad7a05e ("generic/245:
Filter mv error message").

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/generic/682     | 8 +++++++-
 tests/generic/682.out | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/682 b/tests/generic/682
index a51d18338742..417598804bde 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -54,6 +54,12 @@ repquota -upn $SCRATCH_MNT >> $seqres.full
 echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
 ls -sld $scratchdir  >> $seqres.full
 
+_filter_mv_output()
+{
+	sed -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g" \
+	    -e 's/y[0-9]*/yXXX/g'
+}
+
 # Fail at renaming into the directory as qa_user to ensure quota enforcement
 # works
 chmod a+rwx $stagedir
@@ -62,7 +68,7 @@ for ((i = 0; i < dirents; i++)); do
 	name=$(printf "y%0254d" $i)
 	ln $scratchfile $stagedir/$name
 	su - "$qa_user" -c "mv $stagedir/$name $scratchdir/$name" 2>&1 | \
-		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
+		_filter_scratch | _filter_mv_output
 	test "${PIPESTATUS[0]}" -ne 0 && break
 done
 repquota -upn $SCRATCH_MNT >> $seqres.full
diff --git a/tests/generic/682.out b/tests/generic/682.out
index b74708117237..db22d5f60487 100644
--- a/tests/generic/682.out
+++ b/tests/generic/682.out
@@ -1,3 +1,3 @@
 QA output created by 682
-mv: cannot move 'SCRATCH_MNT/staging/yXXX' to 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
+mv: cannot overwrite 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
 Silence is golden
-- 
2.41.0

