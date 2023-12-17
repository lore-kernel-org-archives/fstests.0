Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912645BE4
	for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlpCqDm2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f30d74b68so8405766d6.1
        for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702827828; x=1703432628; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F98IUErsh6KtZrqrULtNIn4eTN8WS7L4PDB0e0NQQ9Y=;
        b=IlpCqDm29987rk5Bb8P4DjCEncHKOyXloNWnpmnASchuN2vnrvPnyq27Y1RUqxpr8q
         YZ5bIQmXWLKtaR7RwnIRRvu2M3kgptWd2SqbGCLHN14hcuiA9h19Sh+qzEomKapI4NDM
         1B4DGhXF6Y5GjatFjPX6n423c5vyqWQolvkbmcmp+UvB2aU8gtOwgZV+ZkNioW3mqvQk
         BOR9f0Z4GAkjonicJmu5d7+LplZf1q/HEcdn5Cr2hHJJsWbnPD7ShHwSXQjcdvLLW1xq
         13SoygXKL7FPZeP3owTMnaN43YELKKHNSAmIRCxEGmdGiAqOtOrDYcuRfT/wJJOKM/wm
         +vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702827828; x=1703432628;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F98IUErsh6KtZrqrULtNIn4eTN8WS7L4PDB0e0NQQ9Y=;
        b=LAN9AGkWKLCPSbRXOrXk+e06WAaQQonkfYmxAskC7irBQOJF6ryQ79ml4/krBfAdFq
         XmB9dGCw2z4Zo+t8b0+8KRUCBPCVPdYPgsoXnsijNoL/oXXlAF5aqzby+rgY/qQzURwD
         qiNVUB9nRP5FPb0xHYTMLLZZvnimpxFBKDN3L7JDa34k6kvI+IXVQW3SyLMHazS8tT+W
         cHOQVrjceYZaK2CGQ9HbvHAuwlbO8k9/JXOEXLVhY9Wc9eOh6vIrCIN88EDHCE9ksWS2
         +GwogQINBa2HFdP5Hlp/3ctSUB/KgHDJKjn+c31C23OVpqG01/bnIa5HvqrLCczia1GM
         LLyA==
X-Gm-Message-State: AOJu0Yx7qgPb+qVKGH3tQ4GsubNJCNM0JUQJNpjB0Tai2WShs6/vpcm0
	c+rWb7xYocgh4/49HicfM3VhCBWFJxsvtzLnHJdDE/QBXeD7FVPC
X-Google-Smtp-Source: AGHT+IH66fa3t855SgbkmvpAHfl7/9P4gJ0D+bMYmzUilFpEmn291ZuvnJNYcFKVFJweYDPUEmeVmQYjNigBvRBTaa0=
X-Received: by 2002:a05:6214:5007:b0:67f:3aa5:c44b with SMTP id
 jo7-20020a056214500700b0067f3aa5c44bmr1102438qvb.94.1702827828430; Sun, 17
 Dec 2023 07:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Alexander E. Patrakov" <patrakov@gmail.com>
Date: Sun, 17 Dec 2023 23:43:22 +0800
Message-ID: <CAN_LGv38+54CQrSb=Xod2-g5Tge2ViTT1jpMu25UGN144AEqgg@mail.gmail.com>
Subject: Excessive media wearout caused by generic/129
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

While running xfstests on an SMB share exposed by a Windows Server
2022 VM running on my laptop, I found an unpleasant surprise: a single
run subtracted 1.5% of the write resource of my SSD, which is quite a
lot. Could you please modify the test to avoid this booby trap? Or
actually, let me do it myself...

The root cause is that the test runs this command:

src/looptest -i 10000 -t -r -w -s -b 102400 /mnt/test/looptest/looptest2.tst

strace shows this pattern:

lseek(3, 0, SEEK_SET)                   = 0
ftruncate(3, 0)                         = 0
lseek(3, 1013145600, SEEK_SET)          = 1013145600
write(3, "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37"...,
102400) = 102400
lseek(3, 1013145600, SEEK_SET)          = 1013145600
read(3, "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37"...,
102400) = 102400
lseek(3, 0, SEEK_SET)                   = 0
ftruncate(3, 0)                         = 0
lseek(3, 1013248000, SEEK_SET)          = 1013248000
write(3, "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37"...,
102400) = 102400
lseek(3, 1013248000, SEEK_SET)          = 1013248000
read(3, "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37"...,
102400) = 102400

This is completely OK for filesystems that support sparse files,
however, such 1-gigabyte seeks are emulated by Windows as 1-gigabyte
writes because the NTFS filesystem does not actually support sparse
files. The result is the "looptest2" part of the test writes more than
4 TB of data.

I think that the test should be preceded by a small check of whether
files intended to be sparse are actually sparse. If not, either fail
or skip the test.

I might be able to create a patch in the next few hours...

-- 
Alexander E. Patrakov
