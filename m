Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAC3E51D8
	for <fstests@vger.kernel.org>; Thu,  4 Jun 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608852; cv=pass; b=X3ldgifMi6y1mqc8nyOqzf/Tn8rHekB37BqqSwgpHQV+VmKyki/QA5WBdY0ni+4HR4BjtxwWgjgzGw+fn0z42tMJxkAoXCCn+D4xcjigx+wGenOyPaI2VAoIgQb13q2vEwuQEMxIGN5/030kEVM3IpRIIDfx11noRfpnZpCYuiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608852; c=relaxed/simple;
	bh=DmVXT1Eux92WsQ7MM4AfhTDPRl8P6+Dxaa8CkY9JKZk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VP4Qq7U259OvYUCs0pBh4SNp5QA3rdzGBT2X1B4MREmxoq2oNns/JuKP6Gh9sJVPan23Xv1aRxvOy8or0kmMJebWYF5eD0OBeSvSPIlQWmNdWsSs9MgCZu58tdH1DXzEWa9qDyhscTeo8tYQZkd5ijLRPT2bSielH8c6N7iwReU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbJctDQx; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbJctDQx"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ce9df31840so8619776d6.1
        for <fstests@vger.kernel.org>; Thu, 04 Jun 2026 14:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780608844; cv=none;
        d=google.com; s=arc-20240605;
        b=d6loU2Cr6995bRDQq/ATlks7PaUE5JOsRqn2u+m9GG9C3s99/hSMExHKKNuaz0tQLf
         Vl4hDN7BaauIhoWYkLjT4Wvq4vQAq3LaXuSJk2ENZgo4JHfVe8zNP1JWLksyoV8BCl9x
         8NLubpJc9n86q8F7QrypsTdqbOUNMPobbvZZ8X3NYko5sowK9adP/LQIMbxDOvGhsTfR
         BI0iZaa7/NB4kVVi08bOp9h7KIg1IpTlU9ovImeD+t/Fsv28dGXb5YJi+3VcFnGp9bkR
         UlDMLreJMYBNDw/jxTZIwDexdPXWat+CN/AkltI9VTPwAOjJ4q2Y6RTlWEV1tmXxAj1Y
         S7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fWOIZTwHtOansRSYZiUMmblIvF/GkvzBekYQ1yitKkM=;
        fh=kaPSe7D36jO4lI2D8Pk1gRsgN0GugmxT8NbOyXqaYGA=;
        b=IKHqPVGAJl65x2Bv0EvoyTPqHfoQ6tcsD0riyDf0RrJYQBgwv8S54bF0RihaAtJ68T
         XLqN2+yhSODJ1x5Y7KVhCAK3Y1Sa3WYnHunAun04FD057a3LbkF+XVFVcGNkf22V37Ul
         wVpZU0qu/vQ/EzxBXI9LG3Z0vwlqIqO8O85aqFpkW2KQ4RUuSUbKQwL/KnvpbtVfUpEq
         msPVZwqFmGyPSwINA2jIHsHPSbf7gb65BE+0XVgpBvSAP/KrvtepGSVqaom8qJOK9D83
         bVvI0u8+mrar1wvCHghEx/RP1H4wC5ZFXyyzO5pbqelhUym20pDaSHIf36HZthKdo9KZ
         OLcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780608844; x=1781213644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fWOIZTwHtOansRSYZiUMmblIvF/GkvzBekYQ1yitKkM=;
        b=FbJctDQxfUIx/q3IiUiGxh8qf77hMv2ulYWcTlfc+WZKcj9/sHk7OwLioG51DJIrpk
         JJGAntFA96PwzpnlrBBWDmYUMCEIl+o1XXv8pxSSdNgnUGgu7RqAvzotDQcd0TCWlIks
         Uqa5+e1s2GxTsE28wZ+UbgVKZyhpJTfTzxIJ4bUkGrhVDmmurxktFBw19RErJiDPygv8
         OA7hBDaLJ/OsiUgJULOb5aEhOGB8MuokTEAIW9KSaZWZI+4wy0IhbjPBJpRwpxi24Zvj
         Ub6LRp6Or53UGmRQ/TqLc45VL4Ybu0X2ICl1llsLD+QZ1EzbGg+99+7KePes6+PZtNXA
         cm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608844; x=1781213644;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWOIZTwHtOansRSYZiUMmblIvF/GkvzBekYQ1yitKkM=;
        b=CDABND6BePtt/sOXqcfuqpBAK4BNo7N29pH9rLbywQ5rnoGz6X4MYOViXTKzq2WLE6
         EoSteGw8cUYb7mAQS1MPhG2hDk1eYiL1jubzBkxeZKHPvo3rv25bZ5h0hch4WKd9xHsQ
         K3BMq2JiFFJDk3UajmbX//mJA0qMTZk75ULJwcpMLJ/3iCD4kNebaa9vvScW9kjukOf5
         Ce7JV6AjTOSdSWx7aSvCQSB/yAGzS029QS890KVR8F356RiiiK1kHEbaywSuw5M2Nnnz
         DPSj+SgZWxzxQXEn317TBcEHaGZGQCYcem3TsbEl08b/FFsVYFK8DPq7RB7/DZ5YTfVd
         ZDTg==
X-Gm-Message-State: AOJu0YyD6cYMQwqJamdJVxxKWt15rFtXKdUReE6QyCDTwJlEVyPyDiHs
	/zkBgzYHQSQdZ5K/L3o7fwi+nbcAm8IgS8NMtFQ9JW/ZX/8H48/LNmsPsaWfJd2cR1J+CgYAcgY
	QRZyGyV0ywMUZ9AoD51G43ufncXfzXMpN6d3Man0=
X-Gm-Gg: Acq92OHTEnhtvSqk4eMhxToLPEEYKs9++kYtrG7d6dgAwpOUIDI+CEyS5T7tjmqUrHu
	zbV/rKDZ8higQRBrwObV7MR7mLLVAUtNA49Fe8rHsxiFnhQCfmjNHXur5iYScKPm+RXUaUxpmQ6
	KvWij9HBiV+uvuQH9/jsaAinm/N5o3KBbG9YGK/ed87a480VbSsbC2HA1XFrf+IUYALi2nJUTs8
	bLpiX3g2fSYNPaZaEz5tqAkqZZECAF19wJldD5IDQg9l2Q0bNnW92SyjQAPWObV6C7rM/4Iwpi/
	uCHhoj14JR4qhElFOtNrTU53zb25ojJXucsG7HLDp47Ex3akuJldroyqcyL9RWkuok0ipQVOdxB
	aCKs22a3a44aoqeISRPbHEDxmEackovPR5d6H1gd0Z+OAa+MtYQk4A08VLfrkzgZ8bOHdq/flW5
	qpwFVDN/kLwUrtk11Lryq3keu8kjen71s+
X-Received: by 2002:a05:6214:1774:b0:8a4:21d9:bbf2 with SMTP id
 6a1803df08f44-8cee6134812mr13161896d6.33.1780608844514; Thu, 04 Jun 2026
 14:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 4 Jun 2026 16:33:51 -0500
X-Gm-Features: AVVi8CcyJI7OL4p2TPs6fNmO2MQmFcnt0X2ajQ02vS9HaU6CL652fIlIMZwem08
Message-ID: <CAH2r5muhUCkLV7=-YAJuj+HmNHPm3+cokgP36XFkkXF6pk6dYQ@mail.gmail.com>
Subject: coreutils problem with xfstest generic/452
To: fstests@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

coreutils behavior seems to have changed breaking xfstest generic/452
which copies the symlink to "ls" to a different directory to run in
the test.   It works with Fedora and some older Ubuntu but with
current Ubuntu (26.04) it looks like coreutils has changed breaking
the test.  Any ideas?

generic/452  0s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//sambamfs/generic/452.out.bad)
    --- tests/generic/452.out 2025-08-22 09:54:32.316786174 -0500
    +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/452.out.bad
2026-06-04 16:29:58.768874029 -0500
    @@ -1,3 +1,3 @@
     QA output created by 452
    -SCRATCH_MNT/ls_on_scratch
    -SCRATCH_MNT/ls_on_scratch
    +coreutils: unknown program 'ls_on_scratch'
    +coreutils: unknown program 'ls_on_scratch'

# coreutils --version
coreutils 0.8.0 (multi-call binary)
# ls --version
ls (uutils coreutils) 0.8.0



-- 
Thanks,

Steve
