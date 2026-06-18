Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE443E6399
	for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777587; cv=none; b=XQfJ5OLJjs8I4dwB1Or1V/mdO7FjLln09IJfri0FIkSuPYSmWElFYeE6B4jKUUfepLcellMc1NMPrcIgmwXM/yvYtmlWUHJ2kG7xAIzf+pDo4APSQBPFdI3UoukXOqFZ+Wv7E8ifQdxuikZuQjrt/8cDE8tJ6emaxDDWmoOqY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777587; c=relaxed/simple;
	bh=Sydr13YG+LkxSxLb+VuMhlfM2ZmKIZRGOQOOc2KpBoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mn3yhCp+VaytuGEJ36CkcIlT8jaHAygdTdYXchQI4n5cePTgr8lq7jonhpjv3xRPdSDIAUPuQ2MRAQjK8oWh97Q9Da+lCBEANAH7emoOuPI/6f0axI07T+0FbEigURjBGAToU1KUxlUsLbineDSg3IH4XSie/cC2AP+2n2/bo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7yUelkU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JU7PgXEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7yUelkU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU7PgXEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfQC3jb/IcagHhe/VvLJeUD93AwtwhorZYSoiCqw/vw=;
	b=K7yUelkUavrMI6TBUPgZfZFT8cLK/NrWlUhIjflu4MHCJE/3eKjIOT6Lrvg5qoLdPqL+Nu
	t9zmWUg1DOpSWf6M278VqKpa93mAj5C6jv0eyDq7MeMRGd060bCmKTug+meDuwufynBt/l
	W1ZYhM7op9TtMZIp+nEED1pQFfLJg50=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-IG9OfQTgM6-8mGurXnbCMw-1; Thu, 18 Jun 2026 06:12:56 -0400
X-MC-Unique: IG9OfQTgM6-8mGurXnbCMw-1
X-Mimecast-MFC-AGG-ID: IG9OfQTgM6-8mGurXnbCMw_1781777575
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so4647355e9.2
        for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777575; x=1782382375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfQC3jb/IcagHhe/VvLJeUD93AwtwhorZYSoiCqw/vw=;
        b=JU7PgXEQ6wrjpSwX7zc9I7/74IAXdNkzaFbWiO8CSDIQfcPEIY8ftNuiKznfHR9dp4
         C92w5AEP+8T6xREW+x1JP6/8DRG3ivF/X/ApIzP3TFn9Noh21EJi0ZMF6skhfYVlIGLm
         4rAczC1friBs6TQHgfd84onOWAL0Vqm2RUlnwXyWTPM8H0mBEeyrgerY/1Ef3557jAky
         9uqJURszRo/oIO072iTIhJvYWUQQiiFqYtzfA8xD7s5yRRxeITTKd6VPjZksAG+rhna0
         sArdkWA2X+zDlJkAdvE0THMART64doB9/x6VTKSdk2Rw6upfiLGWNcY3R4JJ2Sv7N/BQ
         lAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777575; x=1782382375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfQC3jb/IcagHhe/VvLJeUD93AwtwhorZYSoiCqw/vw=;
        b=qvOnA0BW/XGEoKuhRMkFzs2ZsC4AEX3+mX/Ayp5PzOnEcm9wEP2oEj70SrDQcdcsmv
         TDYJxlRBXlHpNcq6fBY7mW+9vyK6eQZ0BeuVCffI8nnpd1VTWxyfa2eQTWimYqVlSYz2
         xLfsYCcv/Y4/HVkDeHBz6UmODyG+BbMVvTvlu1gJ2JycclPPvH9fkNYB5aBsrX6D6MbB
         mRpP+uw8g2M97RR0k0/Y9msDE9EUJyIPd4q7gYepRxbFJarraQCEMfwRx0jJ5/Z/yspW
         KH03wPWJe4sRe9VRUN0jlFEobV77QDDjCo+VJDU0U6qMpLHsndpNGP4wO6RnWrjhUFL/
         omOQ==
X-Gm-Message-State: AOJu0YyM+V0WhuIvSLJu15narNcyi33WlKpCMky9TWGeW8SQQNnuo0tY
	QCzlnkfHFquqte5UTtxdkAaHpREz1IcIAulexOnKw5xFSqAfxxpv2q2IDvLx0heUMVLsDlywBjl
	+W2tKq5y0YapI35DmJ5HEmixZmtiH8cz+/G9KS9PIl8v6GXT+wtMLNWhA8G7AWSylai49kRer9e
	a2nF5yceyj6oHafmlIY3m1/c5TFOZig5c+J62Ln6l3JwD8
X-Gm-Gg: AfdE7cnWNsyVIQ3uP1qHPuYLg4/aF/9JbenrICzdtHjsIlcGNhdafeRGVqMG+LGL13N
	+jvRUjj8GXCdRIy+Mzq68i89kkp1EEnhUqEdaH+HQNYc7mXXCEd5fxDJslc6ltxNgdv2npZE/tf
	x1IL4h6BDafh7D/FVXa7PZUJl3UhAi+NVstRbvITIKN6tDMcxzq14WZnem0M+ImzxuzapCpi5iN
	s324yFO7XcLQtAx5SzUDGObATMIMJQLp2QVbLxEolLUrzoNaIJ1PzNrLU2PMSRkJQ+Pg/jgNzIj
	rcAcL8DJ/GTqry66XGH6KCjY4WVatzdu+ktwNCwe5AP99mNlkDLZqCo91DLjQYtlkJsvArhaNbE
	MkZL7/XOGffLhSxWGTenI5iZLsy2dnoRz+V9UQZr0aNg=
X-Received: by 2002:a05:600c:83cf:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49238225f8bmr45515495e9.31.1781777575483;
        Thu, 18 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:83cf:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49238225f8bmr45515005e9.31.1781777574985;
        Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
Received: from 192.168.1.130 (cm-93-156-201-22.telecable.es. [93.156.201.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm216388815e9.12.2026.06.18.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
From: German Maglione <gmaglione@redhat.com>
Date: Thu, 18 Jun 2026 12:11:54 +0200
Subject: [PATCH 2/2] generic/633: add _require_acls for tcore_acls() ACL
 dependency
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-xfstests-tcore-acls-fixes-v1-2-45a1aec1d99d@redhat.com>
References: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
In-Reply-To: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
To: fstests@vger.kernel.org
Cc: German Maglione <gmaglione@redhat.com>, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, zlang@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781777571; l=683;
 i=gmaglione@redhat.com; s=20260618; h=from:subject:message-id;
 bh=Sydr13YG+LkxSxLb+VuMhlfM2ZmKIZRGOQOOc2KpBoQ=;
 b=9m7U4QL2Dq0hpstvEpBvhq+iw3qnU71AL/fKsHUlU64ciQaOMdi/CjYBb/uQog0Fg3G5FkTj5
 5tQMvDf0GHbBC9yo13Gn3wUTNactXxe2HAP/MMD2uOswkcf2U7HWTs1
X-Developer-Key: i=gmaglione@redhat.com; a=ed25519;
 pk=EgoGsSGnVamWcruH9kiHxwzZf0dPTHHxIjd1Gigd+yo=

generic/633 runs --test-core which includes tcore_acls(). Without
_require_acls, the test fails instead of being skipped on filesystems
that lack ACL support.

Signed-off-by: German Maglione <gmaglione@redhat.com>
---
 tests/generic/633 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/633 b/tests/generic/633
index d75d4dc860d3b78e5fe11b538e3aba4e9ab477e1..90d24f099bc732d5db209f8d014ddaeb042985b2 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -14,6 +14,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 
 _require_test
 _require_chown
+_require_acls
 
 echo "Silence is golden"
 

-- 
2.49.0

