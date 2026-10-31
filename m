Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438401;
	b=DgSKjv29ESstG5EGNOkUzC5WSWUIWZKjgCFig2kfLJPTO3uIfWxQ4wvopATUSyovAAVu
	 /eV/wBHQUuA8jpyJm6cVxfCLrt8amkhls3Yri/wAhiu/wW/SbhlFX20HpX5tpSeouo5Ku
	 dboshtdopNu6SC6ZMgb0YVDRZ/8VhO5DTKoG4Eyy44Y8xR81f6r569sl02ao9TN7ZS9uB
	 ZptD+gSpq4EXiIyGBcurfj44aQH6RPTUWH51mV0CUSaPCkZACqxPkDwkC3HNPsCd4hJEq
	 rUvbrV4N8oC1CzDQWwwXZ08iynB9l9jVDAiTYG+N9/nfzCmTkGilw51TCPSyKoINzyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NgXyymUrfmD9IrHRZPUTZCn0Xdv6r6cUwaDRTXWRhcQ=;
	b=vck7ZlmyBYgZuSBUhYAys8XFTz6V3+Gk5PND9WLfabK9wMDjvFz18eBq3ZCjkASeTlWu
	 rrlHu0DZJZ1Hv6jNgNc0Uveyy0KfrclazWjq+Bj5Wl15qaVIj3RIj9snjhUXojbsrsM/D
	 MS/P1/Trn6dsBZTusIrlX12KEnbZ8pq8csxjl+Z4HqWOos9Zo4hlXT6q7F/dme08a9Awt
	 rmvaC35HQDMHS9I+DX3L4IvIoWB9Gvr9CHJYkS2j3ON0DxTZOOGPJ0Q8lkxihc8gfe1ov
	 69GSPYNfIO2yt4LTa8Ryw7G3fqyAxgfNdnZZNzN6POdBdFMurDzodx6bEkW7uUU0LAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfBW7uDl;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F91606A31F
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 09:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54F91606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfBW7uDl
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a1e794908so379386eec.1
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793438400; x=1794043200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgXyymUrfmD9IrHRZPUTZCn0Xdv6r6cUwaDRTXWRhcQ=;
        b=FfBW7uDldZu/zKJJeoVmxEm7vx005CrAvgQSamGGAlzDh92yiy+UrjpMI/0qM5SNnZ
         YXje3i8PTbOVfrLdoMByf9koNB2B0tpSTPSNYgTadNIH1DVrmvpP/gVVQvV6rAeAQnzP
         YI+3XPi6PKz1w4wp3W3+5KIa0kIo+ZkWFDJmJuFaqqbLjkgDQm3+LRxKEJs0Qtu/rYIW
         sz/Z3PF2kSMVu7tWDVksPUnYp+Kb353xM3JEHhUtgF4qs/2PL/KpPwuaxxqkAYIa4Rv0
         V6r+MqzhH/ROfe1xUtaBO3lanDybc1IgdMAWrzaVebR1lnPvoVVeR/T/fN0BQX0kRmXk
         sX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793438400; x=1794043200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgXyymUrfmD9IrHRZPUTZCn0Xdv6r6cUwaDRTXWRhcQ=;
        b=2V4ZdiGUaDTA7i+BFIIXIbssdyaqGhc/XTOeel4Tc/j8173cqedApWQ/K4zzthOVX3
         fZNxMPROhxB7jJCt56w2ZxKwHkgIzTXbxwSAseE/hnA44T2O47PCpteeq9rb/D9p5lMs
         MN30JTA83E8wVIz7nQOWyz3sqHJ0FVf6yC/pWEzZiHMu9emV1mIAJVMcT98U27bL8FPT
         eGBilljZ7dYeGfZpP4Mv+Dl0PT1in9QCfyKgfK90J2DviUTodepEt1yC/f4KjDHhio/o
         VZbc7+hyVcy58Zo+kWTIG8tGJkU1QNhkCwK9GhdYwY9YlCkKBjIM61Z19uBcm9wDfLvv
         3esA==
X-Gm-Message-State: AFq9FYJ50KIqiJDQyXOd+7yDvH+GCJHT4bJkEr150dowpGaZRT/dnUzc
	5xIYqkG5ZY6kBq83Q6TNpFLYDCjt8KuPxC6XMDBXcR24WPaBaPZsPFjC/lkTab5CHxQ=
X-Gm-Gg: AYBFou1CzLhqWDXSzpdr9RLfroFKWPp/GgQt++zZxFrGq79aFnritlONmpS3f2+XuZ+
	oAx6xNakyOU9dlGpLYcsb5rEcWhvNO/YqdLz2PHeW5sn4aKwW8GD8bv/YGJlwTKGgZUnBCcq0I3
	0BJADqUR1U01cb5YlQqBL10pllCXSzwp73Pp/K7UlZy5vyQMpUSxc5pHGEWB/AbtWuiKpz36XWU
	Z7n4dKB1w8KaHrz3wpzlKDt0htnCRvr90llYA/G+srmdOM9mJxICIqJ2Mxb7hoPu0k29ACmdkL/
	gjR+l9tlz2gkU+ykpAcn3mphKjURD5x6wtKkI3U4H1lA3LoTJgmRuhoRn8jxXgHTJVv5xY7qWBN
	3Zxn1ZMicEUz1pRMeA+9NjMMQ38ITBMY+m2rA4qeLhblHWvkqNCbWGSLJy0XNrdZD0I5Piydxs3
	3NENgzUit4wS/QTRnCc/yjgOpd+DhpTI7eFXgPcC12cfuiORyDAcNb6Hfuw6oChyK3gsQSCrqz6
	OCIipTT/XpPqnINjfTSOsU+7+7P3o8Gn7MLoOtQeGmqL8InzPkMrjRcGtv+x2nTFXszQNLnOsbo
	848FurGWFrcq4JcooHHUCwiEVhGCL3XWKAaqJhtewbocnoYzPs56sI63b8/nqTbsEBaFKQmCrJT
	lCg==
X-Received: by 2002:a05:693c:880d:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-36a4241a810mr7388621eec.29.1793438400295;
        Sat, 31 Oct 2026 02:20:00 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm13067963eec.10.2026.10.31.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:19:59 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 0/2] generic: test overlayfs casefold flags and whiteouts
Date: Sat, 31 Oct 2026 09:19:46 +0000
Message-ID: <20261031091948.18985-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coverage for directory casefold flag changes and whiteout creation
on casefolded overlayfs layers, following the setup in generic/783.
The tests run on a casefold-capable backing filesystem and mount their
own overlay.

The tests cover patches 2 and 3 of the following kernel series:
https://lore.kernel.org/linux-unionfs/20261030113201.2921633-1-amir73il@gmail.com/

Tested on arm64 under QEMU with ext4 and tmpfs as the backing filesystems.
The baseline kernel was overlayfs ovl-fixes at 1d27da7de3f7. The fixed
kernel used the same baseline with all three patches from the series.

On both backing filesystems:
- generic/783 passes before and after the fixes.
- generic/998 fails before the fixes because a casefold flag change
  succeeds, and passes with the fixes.
- generic/999 fails before the fixes because removing a lower-only file
  returns EINVAL, and passes with the fixes.

The runtime tests used fstests at 22348afe338c. Both patches also apply
to for-next at d07dca72d245 and pass bash -n there; the runtime tests were
not repeated on that fstests base.

The tests also need "ovl: check the casefold flag of directories only",
which is included in the kernel baseline above. The fix hints use
placeholder IDs pending final kernel commit IDs. The test numbers
998 and 999 are temporary.

Thanks,
Hungyu

Hungyu Lin (2):
  generic: test overlayfs casefold flag changes
  generic: test whiteouts on casefolded overlay layers

 tests/generic/998     | 142 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/998.out |   3 +
 tests/generic/999     | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |   2 +
 4 files changed, 295 insertions(+)
