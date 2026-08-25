Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CE14883F
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616829; cv=none; b=lWGYvHB/xbUvCRN7uSReO5OMlUPyn0XEV+TP0YRx3p9c6kpxQxxJJqy3BJWazI764zaBvtJSZqA2qxaeY8wkjsWFj8Xbm9g+Oqp7WV6hn3IV1CgN8cdBHqyP4HvEA/QaWB1WeNgKpMx34Tv5WLrjsZTblPaKtkjSN7GAOJY9rY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616829; c=relaxed/simple;
	bh=vLfyE19ZYc4Y7YNPZKUPsvHlMnBUPQpJYKq6eJU3Mdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB9N1QHi/rtup7qQV0I9KJrXUTVsobu5BmY0RSIcsHg+xf1WF95NeaGcUIsVzW15Ur7K+V/ZZvaR/Z6+OnuacrcQRLH0w9zEx/eW6Vd4BSmvf2YkIXbIzm0e6MB5TtOOfmxvB4ttzZXVGTqQiuLgqqzUbd0miZlVm6+fanrH1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUG4uhw2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjM+bnd/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUG4uhw2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjM+bnd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787616826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgF/bn6wwjhV/oe+sPOd5hkI8F0zBms6mRH9MsSB6qA=;
	b=UUG4uhw27AHrOe6hiA+ZBUKdFQI+unNqCQlfF1Sx7+lGgXyFBPIic7QFoaQcmJmNVLrOi/
	72hUwfLmARTf64Hlo99dKlhqjJG/Dkypy2CRgoC0k0sJ0BZyg/hAP9viC98528hleXnl5w
	nx6u+ibXby9GfjIgqRzJJ5lOaiLzcAE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-sI56fTeJMEmvbZN3bRj-MQ-1; Mon, 24 Aug 2026 20:13:45 -0400
X-MC-Unique: sI56fTeJMEmvbZN3bRj-MQ-1
X-Mimecast-MFC-AGG-ID: sI56fTeJMEmvbZN3bRj-MQ_1787616824
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fdc2870fso3360653a34.2
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787616824; x=1788221624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgF/bn6wwjhV/oe+sPOd5hkI8F0zBms6mRH9MsSB6qA=;
        b=DjM+bnd/abDjut9u3KNLvosarALPq4E1SvdEgLJGkzsRFfo65M+RQ9w1hMQYHQhJbI
         JtJAmhwaseAs45ECnloDYxCJLVmDKOC9kFLns4Rf4A4sRJJNmCc94G4ahFMHvhUcsrfS
         nhIEK5oMRYezWOJeEzqSrnNHo6Iq32R5jgkg1B/bMOzTNSmTg5eLYe8hRk39uXQiPTss
         0Xi6NGUhPpEu8NmDQWOnOftjFxghKMJh76gDA2yoM68rnYAwhPTo75bfB6QdwtoyVVnF
         8zIvWGf4ppmmyiTWERjyjyru1UEN9G69sllwWjBbKvTGQKxhu83rJDjCIUlk+A7sLlz9
         9ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616824; x=1788221624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgF/bn6wwjhV/oe+sPOd5hkI8F0zBms6mRH9MsSB6qA=;
        b=NpczQyhKVcbmkAKvhYSn8okg7Pk+sczO4X6b8ObldjuIr4TlwMG6h0WGF9/YCrPoYy
         vPxce4hX3GbQaa9e3pioFBzj3Yq0feY8KJsT0vMtXHCyIDcL5dc9DSYbX+DhXexddLnC
         ksFu9kQnD6+rNJpvaBO/Uov9BRCCF5ekrCZ29cw6G4MLb7eDrDEW4ggs9ugVFIMA6s4s
         DzwPFpGGfMXl9IwvpfECD74I1D0zBauHZv+P+iKTg7/ksdqTN4mQ0/UH26iVhbDPgd0A
         EAvLbFz10loqkUMB4nyKE+9O+zfPEmc+uyrvTgsWoRSMp+pdBxDkcwVrnO2WKX5kCpYp
         iUbg==
X-Gm-Message-State: AFuF++lx12fxgIPuReqeijF134/NRF1/it9KFxZekZxNn9h7F2iRYo4y
	SwomjZZ9vR9w5IyZxGCEeFdH3ehUEENnV/1ba92DgnOQ9SplGiJPSYdScMHNrhZgRT7WRzLM5SR
	R/B12ATU1VcA5q32P+aw/GkaalehGvwVBHEPXMIHUMqsrlz2veS9/H8hO4JBEJpg+QNtnFiLszs
	9pS6niR3pxLxYYhHnr9eePLPLeWX4Cs66ATbrEi102LCDz
X-Gm-Gg: AR+sD10shBaO7Uil0GvmbmiCcTKc42ve1qVFqiwnypE6a4fCQFTKjl7dAG1tMFMIx/g
	QgcyblotMlIqMtDlKHsxq76cCKYmNHe1q+tPHaMZVOAxzTiRGJ+W07q/YAmZHPLbBhMci+R6jVP
	gI+b5i+WcMcKJySLvQ15ihHsmvywpyYbpe41ZKV3lZ3M2Dc8QxJpGa0lA7BRACuhrjuVY8Tr5wN
	5Ej8RmHCKa1b4huqTKh4EwI7QfbX0rVrnomC/wqp306hhBXZ/iKAFsh/dnCMSl0s0eEOTpT6anO
	/39ydtUgp1ZrYSIwz8G0FVm2pdK1gy9V6iZ3Wy7Cl/k3VPgGMBmUgc/W3iOe87V5V4aklTacKIV
	cZGga+wtZjTJt3vpTGY4w4giYZPwpNjr838Uj8Ymw7rQ=
X-Received: by 2002:a05:6820:1c8d:b0:6b1:4d1b:2fdb with SMTP id 006d021491bc7-6b16b4122bbmr19211280eaf.27.1787616824406;
        Mon, 24 Aug 2026 17:13:44 -0700 (PDT)
X-Received: by 2002:a05:6820:1c8d:b0:6b1:4d1b:2fdb with SMTP id 006d021491bc7-6b16b4122bbmr19211237eaf.27.1787616823776;
        Mon, 24 Aug 2026 17:13:43 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm6433923a34.24.2026.08.24.17.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:13:43 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 5/5] Add _require_mknod as needed
Date: Mon, 24 Aug 2026 19:11:12 -0500
Message-ID: <20260825001337.449670-6-sandeen@redhat.com>
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

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 tests/generic/398 | 1 +
 tests/generic/598 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/generic/398 b/tests/generic/398
index a6939b22..927f63d3 100755
--- a/tests/generic/398
+++ b/tests/generic/398
@@ -21,6 +21,7 @@ _begin_fstest auto quick encrypt
 
 _require_scratch_encryption
 _require_hardlinks
+_require_mknod
 _require_renameat2 exchange
 
 _init_session_keyring
diff --git a/tests/generic/598 b/tests/generic/598
index 52541b3e..9cb29021 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -36,6 +36,7 @@ _require_user fsgqa
 _require_group fsgqa
 _require_chmod
 _require_chown
+_require_mknod
 
 USER1=fsgqa2
 USER2=fsgqa
-- 
2.55.0

