Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6033E40E0
	for <fstests@vger.kernel.org>; Sun, 11 Oct 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747283; cv=none; b=ZcUdR7TpGrd47ktds/NawmzowR2+sFyPTINTIu3ERhUDAwpa5Rr2fXbDwHwa0yAjpc1CT6Qtx+dole4/EGTSrr807b4uDhzGgI0xA8QkaVrPusaXZZv0SPqeQRn2w4nx4O3KJK96sVNrZnUglR/+VeICULA8qN5xQOCYApq5gYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747283; c=relaxed/simple;
	bh=mSlKojaJ/5BbVVbMlPvqSJumEQy5p12nXdcD/TldjSk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ifhIbr/+0fSQUCcLX8ETlO6Qh81jFyT6HHOWwlpb+NW5VD9W8L5pCA86K97rqgvzao2YQbqB20ysMLG4PpjVAzJ0em1Z/KL7DTZ8B9CSjEwFZ5YIrMpbhapCV1y1uallVHn0CHsjD0Col9HGqqWWk8htfci2/ci0bqKskRH/638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NENhho3U; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NENhho3U"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2263445eec.1
        for <fstests@vger.kernel.org>; Sun, 11 Oct 2026 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791747278; x=1792352078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pnD0Hgtv2sGUnb5jt+kZQOEUFtoaln33lp1iRDSYtFo=;
        b=NENhho3U5lqPM+fYReD1DLaRbAmQbVhah0xAdBo9AucqXg6MsOl37gnfR6B/Tyixmg
         i3id/edLHCTpVmNCSQgfu2i4sgcS7ctHNfD3X6O+7DVYGu5aH6eENDGtH3cNG/meAVbf
         ictFhwbl7RqovjQDESW90cNPL500URgchT4B6mHpjMBKdebeLj66aWlXvZXwawXhKKvv
         ZQBWQ5WBpMOb+slmdnDiuxB4kxrwh2j+OAphJPisCY/zejWxeyxJQ6XqElfG9sGhwHpb
         eKZ+xMrXlpF+Sq6Zfmdj1QjCFQqdMwNDE0l3gEVnYlXXh1B1GF8ylabp7dQLts8VqOqM
         7Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791747278; x=1792352078;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnD0Hgtv2sGUnb5jt+kZQOEUFtoaln33lp1iRDSYtFo=;
        b=K+dqC913NSaDvyf/2LZY/oA1ji7yp9mcRJk1NUNhI/j420zvMsDHyM0+lea/T5DjQa
         Dmxd9lfHBblx/43NZz9IHcdjyLKmmhXQRZfCKRkBQ6anNVXxTQvgqhD6khSwfn4h/qo8
         rywDzOpVaBZmnQq/+X4FhbwW6voWXQVkXKad2bgkGCsmWQXuxGFvESHYtWsMVYQ6W0jR
         qi7FjzYtoEXBtTzp6qcDAQYfwe12rxzQIDPlDA1PiPikuXsYvRIDNv8SXgdTbxX88HpL
         CtMuaF5Fd61VWqtf5qNLlhfNdTIPVB7qA+QLFkfNjgSI3LGfWd83CVnp8Df+di6y+3Yq
         6RjQ==
X-Gm-Message-State: AFq9FYL03wCU8Fi7teCdmkKzHoBdPfoseA/9Pev9ZnO1ULMQL7JIGylN
	hR7Sa90NCzFeubKNALcOd9zCBh1YdfvOMZPbnOHbAWGBpCL6TO3mTJgYX9/2Po3VHeY=
X-Gm-Gg: AYBFou3Ez4oIUVUVuEupXyScvSO+4Vl+kIzY3uS55yVuocE3YBmpHVu7JAG4n+gKiH+
	nGWhmFlSM5iVbtK1MMDIBVjOxW/XB8+zTrcdPpvG1xhio5PnO03m+Y6PMAuKSbVIjG3ssG2/M9n
	Z0YMyJ053DSfqv54f3SoZvMG2taOSr+Xu29kQOqhok8iGeM0E8QlkQh6oUzVQIqs3P3mpCHy83X
	SI3CahVJS9fnqWrcKVE8rJrAdQGppYV4CSiHZSp9R+Fq3D6IWzgFgkixXtdUt8H9bWWoRhXXTM1
	LECbybTf1tpfzTyH0aBlytF/MB5LaPpjIS4nuFLbRyCLKbJnPP+6zQ6rqZnNX7Ajby3AL9FT296
	bC45uoW2MlGnUIaWbbVxdCft8QzG7In8o8NKmPg6Na5MsltognfT8qYi97BrU4iDNREKUClnovF
	1mBf1TxTD/0pVS/uJrs9vSfO5G3dICxeOw+fAs7YDF4e4T5h+fhmdAUgA1zrmH2ahHlq1SZedzO
	gz/FmZHu31ukUb5jSVnCIrA7bMLKWl3ZBVS0HaEDFqkI9Bhm+W3ndFnazA=
X-Received: by 2002:a05:701b:261b:b0:154:dc96:c1d8 with SMTP id a92af1059eb24-16a54ad2602mr14769671c88.2.1791747278258;
        Sun, 11 Oct 2026 12:34:38 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:97af:bd42:ace4:1245:4b57? ([2406:7400:56:97af:bd42:ace4:1245:4b57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm37177580c88.18.2026.10.11.12.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 12:34:37 -0700 (PDT)
Message-ID: <51964611-cd9b-48ad-b6ca-45373a96f64a@gmail.com>
Date: Mon, 12 Oct 2026 01:04:33 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dhruva G <goledhruva@gmail.com>
Subject: [PATCH 0/3] btrfs: add NOCOMPRESS defrag regression coverage
To: fstests@vger.kernel.org
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 Zorro Lang <zlang@kernel.org>, linux-btrfs@vger.kernel.org,
 quwenruo.btrfs@gmx.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add regression coverage for BTRFS_DEFRAG_RANGE_NOCOMPRESS, introduced by
kernel commit 009b2056cb25 ("btrfs: defrag: add flag to force
no-compression").

The series checks bounded conversion and EOF handling, preservation of
holes and preallocated extents, and inline extent eligibility and short
EOF tails. FIEMAP assertions inspect every overlapping extent and require
complete range coverage. File contents, sizes, and extent state are
checked again after remounting.

Patch 1 adds the shared helpers and a small raw-ioctl program used for
feature probing and errno checks. Patches 2 and 3 add sparse-layout and
inline/tail coverage. The tests require 4K sectors and btrfs-progs with
--nocomp support; unsupported configurations skip.

Tested on an x86_64 QEMU/KVM guest with:

  Linux 7.3.0-rc3-next-20260918-btrfs-lab
  btrfs-progs v7.1
  4K Btrfs scratch sectors


Dhruva Gole (3):
  btrfs: exercise NOCOMPRESS range and EOF handling
  btrfs: check NOCOMPRESS preserves holes and preallocation
  btrfs: cover NOCOMPRESS inline eligibility and short tails

 .gitignore                |   1 +
 common/btrfs_nocomp       | 134 ++++++++++++++++++++++++++++++++++++++
 src/Makefile              |   2 +-
 src/btrfs_defrag_nocomp.c |  63 ++++++++++++++++++
 tests/btrfs/355           |  80 +++++++++++++++++++++++
 tests/btrfs/355.out       |   2 +
 tests/btrfs/356           |  71 ++++++++++++++++++++
 tests/btrfs/356.out       |   2 +
 tests/btrfs/357           |  59 +++++++++++++++++
 tests/btrfs/357.out       |   2 +
 10 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 common/btrfs_nocomp
 create mode 100644 src/btrfs_defrag_nocomp.c
 create mode 100755 tests/btrfs/355
 create mode 100644 tests/btrfs/355.out
 create mode 100755 tests/btrfs/356
 create mode 100644 tests/btrfs/356.out
 create mode 100755 tests/btrfs/357
 create mode 100644 tests/btrfs/357.out


base-commit: 56c410ad0f69da5b13c5807bc47b4876dcfa02b2
-- 
2.43.0
