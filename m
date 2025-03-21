Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A813774D
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587777; cv=none; b=WoIUrCV0ca5imhtn7BF6he2vEIVJxf3zxOYpAmScS7hsbshBddCLHAsAiGamaOrxjz67UkIow5+tVoDPzpOGkwgA/gMiL3y0Kga5qooTxWgoPxkj11hpQ6tsuJnKgJRKVwBjD12FhRPKcXHj//bkxrKyHOQTJix/YU90iQ0jtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587777; c=relaxed/simple;
	bh=Pw88twflFgWqxp2gAEw5aEc7ZdK3vmsvS6x3hNboVz8=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BrUTl7eTUIFAM/X5Sa25R7vYdFSJikzk8SlHMWUpLQTgrPf1tUynixMmsxmOE86oFFnN2S6zxBnZhZnVdMm6QbbNyHHnxppigacf7CBZYEPZou6VCaaSZrG9qc9QRhtgkZYEGn1/6CJ/AHsLFU66PkSdfMn7xjY/yXchjnrhNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1pKAqzB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1pKAqzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742587773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=/zI7cAWG/u8b/ooWTipS/X8Vnm8bzWy5o4vNuYFjme0=;
	b=J1pKAqzBYPf6L/QI/laYIlolj+Ljd9XReM2/9Q56vfaWUhLOf83IIAzH6eBrQIeh2OTgbp
	5pT6K4M3aGdI5Rv4D0kgbAdz3wegBCVXp0QYEam3dr0dxhAFhbS0/udx+263QEFbaV58sr
	6/jPm0ffAyxa+qPl1D3WrixSLkfZTGA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-bnWc3wynNNqJbUTOHH7Jzg-1; Fri, 21 Mar 2025 16:09:31 -0400
X-MC-Unique: bnWc3wynNNqJbUTOHH7Jzg-1
X-Mimecast-MFC-AGG-ID: bnWc3wynNNqJbUTOHH7Jzg_1742587770
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3c16d6199so216812566b.3
        for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 13:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587770; x=1743192570;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zI7cAWG/u8b/ooWTipS/X8Vnm8bzWy5o4vNuYFjme0=;
        b=lLt1/SEUG4Du/j6Qxxp0CUqcqNRe6fJtwNNMORqc55PXkDrD8ax6Ez8VMZ3MrUkfhn
         C1DIiYVMb1O4BzUJsrRt4TaZ1XBEo7OgBQ89ejegx14LnDIYGuxJifKCDSGSktrMAe/m
         1b0tJZxmflWtKbnwJ56jV+yv5/o4NO/dyk2irc0IU/Fxcy3N8PJhp3ghmCi5Gq/fR5up
         7lVVKEkfAPTqdV458egnakBTTM1TD1AgMJuOVJ36d1rBo1wc3kBBzvpAJnVbQVdCUgCe
         HUvUB1vs84T/yANckZMnJHtv0bpKOaOg1c28wJC2jjfzD0OB8x2gnUQQVyFa1Bwge8vb
         nOcg==
X-Gm-Message-State: AOJu0YwpeRMY4GdQjTVO67ubyzk9O7Wxv5lPj2eYetMgfKZ+a5EBoGgD
	1qG6diPWk1YZhJc5d9zvg9awldjl2a1d0DH6IygnMVfCKA9A6KQChMp779un+wVWVAdoam1Y+3U
	sUuhGykNFMdvDuGwZqApA1ejhQEFLTAbOrOwmlVs/NYXkE7Q4t4ZDBxmEXAaZ8GAp
X-Gm-Gg: ASbGncvUEUJ2W0VAKpBN0KPK+VHBVChwU8bpTnkXzagm+HD+ySYy7TNxTCeqT3ZFWF/
	S0k7Mt5Nma61QbKb4k5YTEoT4OUgNposIukVJKIwZi5Z76SA39GdqvbvV6NhH+MD4vl/XTMiMQT
	69AeGJB0sg5TkDoBH7XNZxRfD+AlLz4cidlnkQLcTC707OFjECO0vaLPBgMApTcmdnCy3V2Q+bC
	hEhgRonfGyRzZl2fNEpIEJOP6Sr2NjBLEVPQbBWuogzjNJ8bksvfwBuH46mb1GlEl0BycbvZRCb
	3qY8AtouWkBXpy9CG6hsZarujurSkGQi4CU=
X-Received: by 2002:a17:906:7ad2:b0:ac3:3f11:58ff with SMTP id a640c23a62f3a-ac3f24d7a85mr395610766b.45.1742587769820;
        Fri, 21 Mar 2025 13:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJwiwuMJ/ZVgCLGSFFvCbXoz4aM+rEgWbKNzc8M4dEMFUQSp3l8Pvea0ntdNBSonBmooANsw==
X-Received: by 2002:a17:906:7ad2:b0:ac3:3f11:58ff with SMTP id a640c23a62f3a-ac3f24d7a85mr395609466b.45.1742587769383;
        Fri, 21 Mar 2025 13:09:29 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb6483fsm208028366b.112.2025.03.21.13.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:09:28 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 21 Mar 2025 21:09:28 +0100
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/2] Test getfsxattrat and setfsxattrat syscalls
Message-ID: <20250321-xattrat-syscall-v1-0-366175071708@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOHE3WcC/x3MQQqAIBBG4avErBPSsKKrRAup3xqICkfCiO6et
 PwW7z0kCAyhvngo4GLhY8/QZUHT6vYFiudsMpWxVa1blVyMwUUlt0xu2xTQeQszN9Ad5eoM8Jz
 +4zC+7wdZaC0SYQAAAA==
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=60StqbCPZHgsnqqpOpUig/MUFr9mjWwaK8UHp6RcRXc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8eeZg75eids13G8YabdjT3X7z0J5BZ77f+9wf71
 PL7LKNEdQ52lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmIjMRIb/KQ6x341nq5TF
 8lifEmzdGdD28LFTjmrbp6z70++++zXlEMP/aolU5Y6+D9rMyl6Cfnld/JN6nRetilq7lPP9ypM
 b/dOYAOWbSuk=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>

Add a test to check basic functionallity of getfsxattrat() and
setfsxattrat() syscalls. These syscalls are used to get/set filesystem
inode attributes (think of FS_IOC_SETFSXATTR ioctl()). The difference from
ioctl() is that these syscalls use *at() semantics and can be called on
any file without opening it, including special ones.

To: zlang@redhat.com
Cc: fstests@vger.kernel.org

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Andrey Albershteyn (2):
      fsxattrat: introduce program to set/get fsxattr
      generic: introduce test to test getfsxattrat/setfsxattrat syscalls

 .gitignore            |   1 +
 configure.ac          |   1 +
 include/builddefs.in  |   1 +
 m4/package_libcdev.m4 |  16 ++++
 src/Makefile          |   4 +
 src/fsxattrat.c       | 246 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/764     |  97 ++++++++++++++++++++
 tests/generic/764.out |  26 ++++++
 8 files changed, 392 insertions(+)
---
base-commit: 160362bfb7df528fb21c33068fbeee5a3c1410fb
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>


-- 
- Andrey

