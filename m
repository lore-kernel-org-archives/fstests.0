Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FE3BBFB5
	for <fstests@vger.kernel.org>; Mon,  6 Jul 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365211; cv=none; b=VhcO8x515BMHq5Dryh5LDTILjuhc0GOa82Tu83JQw9DU/ngbX5giJGiI3dkGnpncklMcecOIITF9ke94O1CkKHkfUkjACX/QzQt/S1A9KhkEmkbcLys49eA1t+lH+VrZRM/ypWu+rS0QUv28FyIyWzWS4M6UNifxhMzfeqjWikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365211; c=relaxed/simple;
	bh=MhpF4KJ/YbMsJoognPaO5gSvgED7AAobWObQ9gCWIik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkvr39jJHYVntz+rjwKcoF1xUgwS1PWdc9Mxmjmo5082Xu3dJfN1EqCxxPjtiMeksJOSWeLco0cWs20ooLiVzGT7lniXIeFC1DqRODGEkq52VGucMU6YlayLRO3XOVvSfsknz4+wVP7KnE/nq8YXpAdwyfhvvTFIfLfrrtRtdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cbfdc8N1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cbfdc8N1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so23631075e9.0
        for <fstests@vger.kernel.org>; Mon, 06 Jul 2026 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783365208; x=1783970008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPiUTZJfQDYEPkKxNurLX/POyRzctvKyNbWcsmHIGwA=;
        b=Cbfdc8N1jMbl4C1mJ4P+IZ3Ij0/eZYUAlH0QezekCPVc2gtIh1PY3ypg5WstFyA/50
         qlH3KJPOeiYY0ouJIPE5oYQH2Lybj7QcWkv3t2j5s8I+iOFDZ6TvWKCQB07RxsVcXBxL
         ux/kCFcSz4HTJBJiSeHWceaB4mPGpcq07uvmTbOaGyRG+UyimzmNmiLd1YNlGnt0fr9u
         4g5etpbJlndRyfy9/dfk5QoUPiyZQLg6zss1zrJxXk3se+4kW89FhT+LkqqpNJ4Kf63u
         mlpDiJdiGhtAOid5KAgoMWmJV8TymF4cI6qvis5+Di0FabgiTnM8KpeIPJvIS5xk07+s
         /azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365208; x=1783970008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPiUTZJfQDYEPkKxNurLX/POyRzctvKyNbWcsmHIGwA=;
        b=BXawiHuDb9G5L4aiVYcFyLuvamN8g1FWR6Kwk/57QUnrCM5KFJcyrbwDXzWKKhgSQV
         pjVcDlgTo5+ytYdqJkxo5qGmPZoaRKjN1Cs7HMGr7MZlW9+XuewVl1j54KdRMYGBsMur
         bG1Zjz2M6dnDl5pMHw4++MaLfRtg0iuplwwee0WlBlKAgofsEljcQRLDNqaD16hpruJH
         qCwCdMzSyt8ix2Tb7Zy+Y5h2xCpjK/3oQj3Hs3ecLJuMeJbjKbps5eeiXQHQ6hZPxZxq
         iyZU+cRX9R77ZCf0q1AuBTxdp0WU5XGYjOpCOTLONytAaL2jGMAQLeKO5eX1ebc2c9x+
         3DYQ==
X-Gm-Message-State: AOJu0YxJCeUqIdbicwDoMLQpoTN1ktdvFkIdqsy3DIPStvypprwi1KyZ
	Uflu9slxBuFKtk7Pv3L4j2A3bYb7g40Z8lmkBs4WU5idC6D8nkVjixwDrCHaAX5Yc3trtmviybp
	Rk3Dx1ec=
X-Gm-Gg: AfdE7cm/zHCSGN3y2Jh5St2s2nhbZ3Nm6a5nPoKwKAoqgqF/n3k4h6kjGnvsYWDkhov
	RrgMLe+uQHD62UisWRxyE1pAmnpZVBglY0GxyaxNqU59AeLumC2A6qRb1nT8YQu820PiPy0Lzi6
	Re4khFCYZMlNhflwaBsuUDP3ZtEj5oNNRcjuIJBf5c7yMrxMRyGESRr/g9VehD3I5CaoyuEeGfF
	5zdk+/3C+w/BR6/edum5ixlqS1YrerNhpDLt08bnT+jTdWax0A71ny4K1X/wDmniLrnmm/IQF8F
	HTGMWQa7mUibiASuwgRYcvGE5wuSqRMVQKCAjsm40XOsymkQ1ai1b8ESGKQsYaYuIcwZxSMQi6h
	+pr9vqYWiZEP1XVlESbw1fw9zSD12873tfQjxfT+WDwtSLDY89mUGtWmi+INCY9HTfVyGRtGsF1
	U=
X-Received: by 2002:a05:600c:8286:b0:492:4911:8a with SMTP id 5b1f17b1804b1-493df040410mr21492575e9.12.1783365207798;
        Mon, 06 Jul 2026 12:13:27 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e01f570bsm4802555e9.10.2026.07.06.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:13:27 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH v2] generic/062: filter setfattr --restore symlink-safety warning
Date: Mon,  6 Jul 2026 21:13:26 +0200
Message-ID: <20260706191326.122555-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706061102.90603-1-avinesh.kumar@suse.com>
References: <20260706061102.90603-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" warn when
used without -P and the dump contains a symlink, which generic/062 does.
The warning leaks into the compared output via the setfattr() wrapper
and fails the test. Adding -P isn't portable (older attr doesn't have it),
so filter the warning in the wrapper instead.

[0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 tests/generic/062 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/062 b/tests/generic/062
index 89659040..ddf0a478 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -30,7 +30,12 @@ getfattr()
 
 setfattr()
 {
-    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
+    # attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
+    # -P/--physical is unsafe because it can traverse symlinks. Older attr does
+    # not accept -P, so just filter the warning to stay version-agnostic.
+    $SETFATTR_PROG $@ 2>&1 | \
+        sed -e '/^Warning: option --restore=file is unsafe without option/d' | \
+        _filter_scratch
 }
 
 _create_test_bed()
-- 
2.54.0

