Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484991;
	b=HcC9nNqBwuPsToFyw5CPsOXUZkfLJoFcb+4tLiv3wQt5z4x0ddiW9tSfw4hNXVOTe3GI
	 cphvhxKfHLv7lGk3aMg8kJDMBD9XJ341q2rez34oJuuYXvALN5QjnK5f7J36qYtoc1810
	 AcOrainOcnVKz8E1kOPOBTjZ7PY6WM3N1OrH3J0OQtYtV66iQyJXS7uP9I9HT4JK22r99
	 N1Vh+v2B42q/yfFON6upjMh5fjUEzXkulN406XDRsTBTjgay/OjZnpAZZ44Yg4U7+oXQS
	 8vwqFVb/yee0/jKQoADtQUdLIjePiHYSolKy094H3IGGcgKcCA1x1MtfUcKhwFiA76Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7KpXA9R9TrTF1xZIX8mrT8HYSsUTOapDQnwWe5ksxdM=;
	b=syiXFlFfDmbWc1j/6SuWGjTmeUS6BQ7cPlvrMcfWECw7n9ZYlZeoFYCOeWXzOKTsnqJB
	 IXEWmkQ9DO1e5jUc4T0uyhsXdjQ2i6yfurKnUKbi4JmIgH1tCchxiByakH0MqU/nQMBk4
	 Lm9wQ/KpMMHiGInRH0iFjP4LcFqQfLXhnK2O85YB+tEfQPT8YdBMA+ZUxrPE7vwgSAWVI
	 nS0VOj7hSDFofyj2oIV9Wg48rXutLfRrv/oLTOV6xhc4/RoBJhfEtMTJnLD66UKJPNXxd
	 3VF0EEXYeFjQBRe0kCXX8hLcXs+vyW6D0ytd6JLR/MF11bK6IR2Mpa7KHTpz014thNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzjihoSY;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA8606A31C
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 22:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95EA8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzjihoSY
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so426373c88.1
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484990; x=1794089790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7KpXA9R9TrTF1xZIX8mrT8HYSsUTOapDQnwWe5ksxdM=;
        b=NzjihoSYQm5UrRty1Z9U54fqcQtfIOFCdLvCXsAZ/Eb54re0wlV1iWldlAxy27C2R1
         OLGNvMWqYarW5/X5pRYt+AgAIz5C9IcFSB9K5qRnNRtqsOmANfRyomAA6UKaHRtCK6mG
         iwKYFYSMR8F+lUJ+22vzr/Yzg+L9dZx5j/JnYy5fKDd1zcsA/NNR3Mf66ARd2BurOrNR
         mqyGyxbrrktE7ezxo5V31VyKBvxZkhOzFWCfzbLd5+yak5W5Ca5oCd/5AQI6mjeo1aZN
         mkLpTmeUR0deeEWQUVnACknzz1XIOcxULFxo8eyrS6J/zqUaFDLEnZVkmqeE+pHIqHse
         zHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484990; x=1794089790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KpXA9R9TrTF1xZIX8mrT8HYSsUTOapDQnwWe5ksxdM=;
        b=Wk/VvvxR/qa7qtLqQp0VNF/mYbcT4i3xz9IU6aYVZpKaT71pkS5QJP9KMw5RbTyRXY
         o+D/NFmL+rPjESJsqSYS+SqMx+y3gPvfpDJTX83FXnxGkeEsWD14RYKAftRC5/ejCj1s
         daEsgahy3qebSVmQFo31ta//cK3kCWmQE5iriBEhJ2MYlpCGhW8FIjOkZ/7AupmSC9y2
         nBbL2aI+aSaxrk786rjDxTUasclHfQunlqpHcrxgwdfxvmzCpm8gNa92vyz2QyHCk258
         ty0YTAdYzUozGlNdVuUggNpTEen6GUZ517shh2p8BZq8AFvh2hvkC0iovPOZwqGVSCj6
         u7Iw==
X-Gm-Message-State: AFq9FYKA++IhZaBkLrWqmEshX20wVyFuqxJM0tg4Ohk7/E85gniUxloq
	CrSbd9UDZWUt+wQiJJLOnTbQ+yVtfCoXvJN876rdO7mnqzw1mii7aV5rJNk9T/K6+4o=
X-Gm-Gg: AYBFou2QUZRU/+3WJFQ6uDglFZnpXbtvbxk2bfUKFoYlRJ+k1yBL7JheQE7h9ttQtY4
	n5HpsykNpHbq8IaPg5+I/RCF339nO+5s2xHBBrHEsYr8zNwcRYoBUjNyznUyc+5nECcKXf/pX0M
	OWRq/l5GqPA81Wic/60U1ZJXZjmP1LviORiWUqpfBOAhtWD8PwK71Uyr6T1MkrUMURgjZYWOcgu
	+FBaS/y6yDKFBvULpfFlZP0GX5AT0Dz4Ja0kFnw5U5U4ZUDsJHhoDo6pZgDayK9BCjwse233qfx
	TO1cLBW8CunkRVZBK8/hWExnwzSAwiwDOBbrSIKD4/Kz/wpi+fI8OVsJDmygrPJWfY7jRdMs+fG
	6MOmCqvyfzOCgAlDrpSd14TIVEFUvey69s+fuU6Oehe5E4vY/Qd19aRf/1lChH65bbmFegTrutm
	mnPGOI4ZVbXQ+y111U0PBGgr6BO+smW9GXe9UG+eoPfrMpKLHolWadWZm/dWlg7lwCiRVAv+aNM
	DRpyrYIMn27SLA6ppPmcyVwi4IjXSlb4dyHcJLijWZgMcmso3QWl56qcydQ972pYNZwWcI3ZVZc
	uLm5JHzF464nr/AhwdguRZoz3jT+JHPNGPj4hmBNZW4tD4MwVDl0Zq7zrA==
X-Received: by 2002:a05:7300:c00e:20b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-36a4241b0b2mr10640559eec.33.1793484989524;
        Sat, 31 Oct 2026 15:16:29 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm24037242eec.22.2026.10.31.15.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:16:28 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 0/2] generic: test overlayfs casefold flags and whiteouts
Date: Sat, 31 Oct 2026 22:16:16 +0000
Message-ID: <20261031221618.153-1-dennylin0707@gmail.com>
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

Changes in v2:
- Move the flag test into test_casefold() and call the enabled and
  disabled cases explicitly, as suggested by Amir.
- Add Amir's Reviewed-by to both patches.

v1: https://lore.kernel.org/r/20261031091948.18985-1-dennylin0707@gmail.com

Thanks,
Hungyu

Hungyu Lin (2):
  generic: test overlayfs casefold flag changes
  generic: test whiteouts on casefolded overlay layers

 tests/generic/998     | 147 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/998.out |   3 +
 tests/generic/999     | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |   2 +
 4 files changed, 300 insertions(+)
