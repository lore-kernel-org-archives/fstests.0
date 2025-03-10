Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9B155393
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631408; cv=none; b=XdYE5RvbbJZ7k2ogHiScRF4AvBY3hMcPZtUl1elLndMpnybheuE+HXBY4hWhq8MvcbDj/01mtSftKzK1Ziuyd3N0RPkes9Rmcx7/QnSeTBeDUnjC4iae3uPgdg4vMce0fG8t1MuzHDn6bykEDaS/KSvk8KfvzUBqQE92Vbj+0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631408; c=relaxed/simple;
	bh=9Q7Py2bnLyippDA+94RMm4w8ETYur8LkWSMq+msM2Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOQYxCKVXIpD+9XoyrjvZVanNiCis7ppZpn1cImPWQqbBiiKGE6rE9HGOYyuazuXi44yNg5d4ZbNhmZJoczO0hRb+AKTnp4vyONnmEMNun5vgDHYUklQFAh9NQeljyHkI+a68MY/LlmBHUNzIdwJNXrPRtBKZzFNHtDzm2UuIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5tFzkth; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5tFzkth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWnkmrJjEm4LokhSnpmQEw676unRv8bGBzQ8jrQXABY=;
	b=B5tFzkth2JtMA9sVOjxUhfVDF4yZ/we5reTmOwKecdfzIDuDTtVFomweMTRMyO1qmWIjb9
	UiIJ3JiWpF9HjuthTUwcLPEP69thIIccVvSPGKijhSDZP1+0GN4GilAxbq6BLIu4O6WhrJ
	qddnjTYSdH1CinK1JU8T10a4uTGHkGw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-v0-CcqOsPXa4XUpOJMJvLA-1; Mon, 10 Mar 2025 14:30:04 -0400
X-MC-Unique: v0-CcqOsPXa4XUpOJMJvLA-1
X-Mimecast-MFC-AGG-ID: v0-CcqOsPXa4XUpOJMJvLA_1741631404
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85ad875acccso1032795039f.3
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631403; x=1742236203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWnkmrJjEm4LokhSnpmQEw676unRv8bGBzQ8jrQXABY=;
        b=RigXcPVexn6kIZrRH0Mux2jPvSMMMKYIgOzz1BCSRCHqFYWT85yQJzYJWGd/a431yp
         2pgH5zkt9T8bEuPkzv1vq9qcBw47DgP8QBuI4mMNWzqCzNXiYxEvM2nK+kwgx5O3OXmR
         XacEHaJ8Fkmssv/KaiGPTj/PtPSFp+MoaLmCD9Bt0m65Q3wbvLqfRJ5ZtNc7Wix0GDmO
         qcyn+SHYMSGU378pKlrtJ69/gCeROxw+rLkmj6cEiHa3tEd075w6FqvgWUhtg2R+acoi
         abyVkuZZtZ1XnT/j+vzRnFPuvUELoSIoZffgRR7u0A9se45CbqIVhVfvcolvom4SVrqv
         HvjQ==
X-Gm-Message-State: AOJu0Yx/1lSIAY8kJ53HWZx/dxPRf9IV3tQTiKMx79w0OOI1yZ5OIrXp
	jBSJFeV4NBkvnRaGUOXbBDzjxzhsMUGpnTv0nq/UozsUuE4rLlO5vCi3fltVhrBOH0v28snXWER
	e8ZGT1tkYAXQPYMLlWZPvMy8D6IXe1Le/tq1M4/6ZXH5sqDrrMoGgaQM30CcdR75QD3Z2UE6oR3
	26bwz79qX3y5RfrjGUlbCaNddzs/FubghFGU5ChnvL
X-Gm-Gg: ASbGncupJ9SHcKwOUzLfQl1CSy/qJkBAbkwL0G0qw+Cm3A93nKhj/FPrXOUOAy503E5
	1Hb64czL2Dgq36JTe616f6xnI8jMtLdetTlSM+dpL12XYJDx3Dc8Esx0RPul+QzJGKMa/RIleoy
	fDPPWINWUpn+IvTmrmqkGE2dUkwrWKGXf6+lh8mT5DesyxD7eWYIGWPyvaOY+siTab8uilWOvtH
	9iaYMtS59pYls5xcRkQ+oLAFlYaJQhZ0af+iB/V1QNRhWSTTfXrjb5CI3zzdIfe2q/ujF6Hi922
	HYR/vTy/VPzlQJVPhRvIi6S1LuiGGK4=
X-Received: by 2002:a05:6e02:1b0a:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d46890d179mr9240385ab.5.1741631403619;
        Mon, 10 Mar 2025 11:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERwb88aMen7Qjf3hR8EUXwCKhaZxCe+vgMvJ4c4hyvS2ei3zdTgqaeP9XGdsBXap9djA5RnA==
X-Received: by 2002:a05:6e02:1b0a:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d46890d179mr9240195ab.5.1741631403239;
        Mon, 10 Mar 2025 11:30:03 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:30:02 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/7] lib: make a few symbols static
Date: Mon, 10 Mar 2025 13:29:08 -0500
Message-ID: <20250310182954.1396724-7-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250310182954.1396724-1-sandeen@redhat.com>
References: <20250310182954.1396724-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few symbols in lib/tlibio.c which should be static,
and sparse notices this so fix it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 lib/tlibio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 9d852ff0..73851fd8 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -82,6 +82,7 @@ static void lio_async_signal_handler(int sig);
 /*
  * Define the structure as used in lio_parse_arg1 and lio_help1
  */
+static
 struct lio_info_type  Lio_info1[] = {
     { "s", LIO_IO_SYNC, "sync i/o" },
     { "p", LIO_IO_ASYNC|LIO_WAIT_SIGACTIVE, "async i/o using a loop to wait for a signal" },
@@ -101,6 +102,7 @@ struct lio_info_type  Lio_info1[] = {
 /*
  * Define the structure used by lio_parse_arg2 and lio_help2
  */
+static
 struct lio_info_type  Lio_info2[] = {
     { "sync",      LIO_IO_SYNC,		"sync i/o (read/write)"},
     { "async",     LIO_IO_ASYNC,	"async i/o (reada/writea/aio_read/aio_write)" },
@@ -120,7 +122,7 @@ struct lio_info_type  Lio_info2[] = {
 	"all random i/o types and wait methods (except nowait)" },
 };
 
-char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
+static char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
 
 static volatile int Received_signal = 0;	/* number of signals received */
 static volatile int Rec_signal;
-- 
2.48.0

