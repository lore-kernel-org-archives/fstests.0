Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440C36680F
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296937; cv=none; b=RAWE7OmapL6bIRIy6wghVqw5k3rGTGVdRLWfxTXo9hO0Z5FaGDKWx2RY7tNhWRs4m9qPldt1J3aEmtOW0mXmZqYqwrTyS1Bcuf8GSd36fDwbp7KvU4XHvg7Abk7OjcCkd6SkpStWOmtMRCSpf/Vz9Nxd5fcScdcccJOMnRvTyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296937; c=relaxed/simple;
	bh=MF1qa2PS5UiXG6+7n9vWd6AOz86MM/IrfgTPqQ/Njv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPD21NuKtfQ00q+Q7ii01zctvjkjZMqeANIm7LojyGLm9oF0YDh56Z0pu3Hwkoc6rFndRDUA3TBnT81VbuCf7zCdjd/W/FPG/LxFxEqVkLISyvgClr/DaJF6f1AKbcoNqpX9e7eDA0vP/suXaWzxHKlsA8jmF21CQXUuDV6AuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXZhH4Bh; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXZhH4Bh"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64ed548c2f6so722920d50.1
        for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774296935; x=1774901735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sA/e4+zJJupwo9/Rw4ZAvXqt0f+FgliyX2OB04OaLQ=;
        b=OXZhH4Bh8r5Z3G8HTC+wP4vuXu3KFnV9cqIdQH3wxAdobtAn6SMLOtcHukF8KQY7db
         +54YtQI18wj0iMAiZnz10DlYB9AcxOvsxgzORN7+DV+RwiMlBZ5fIHcgxRhbUTfPZClL
         BiQiDEVN4UssOJmXRomjfH+PERAV5NAFm22LKOfkobd2G63tDrWYilRkDlWzwde65qGm
         /pPdxOFxAOLHSl32iDhELubIvQXs3d9Wj1r0eDdZG0FE3577eBRY1dVyAHLxO+LYy/+h
         pYnnA6keQTkqLj6q+hyokPfNkPhXOcIMjO29iHVGh3YFQe0QGGmdiCul+TYxu6xaujCP
         yUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774296935; x=1774901735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sA/e4+zJJupwo9/Rw4ZAvXqt0f+FgliyX2OB04OaLQ=;
        b=k6gPA/lQxAqv2A4QvB4viZC24DGIT+y2kvTBfyOvSqqEjW5NAmKKIAYoUr0vHwveJz
         XYgsmUotaCW99xd1e2uHWRfbsdBuuTt040XYc/J9qrzndXLTW3/n43a+ZEqfAk3/XH0u
         mYiMaFoeI3nOeQUmzapdbwTiHYgd7s/tU1IrRZQKONhhV92ULP+ZG8RRAiHc+omkly5O
         7BsQSGsAiLrBfJZ1UY9mTO7o8ZE4iUjuKNMox2tgQ40B+cPNpepWy4Qzlp20KUhZxnzX
         xbFeDxrvaLZEC1uXMyVoP25D8SY2cmmr/cmCHH6wUQYtcXDziBHcS2QZlAnYDH0l38OQ
         WLJg==
X-Gm-Message-State: AOJu0YxeJVKt8n98a2CPbf/FRv4i/Z3CkC0vOxk4tr7VIGYLMWHYksf8
	NCMsB72LNigWLRyVwxOE1pr3AQr1/AAiGT53FFuYHCbSIM0w29y4mTJzKfV+DRyo
X-Gm-Gg: ATEYQzy0uDQg/cT9FylMrTBYfb+1pWjio3LEn9yT8h9dfVOODz9L8O7IsAn6nh5/3xM
	TOjajP7muJCsudjkW6+S64V4LT7L0m9PpvaFj1yAyuyxI4cdz10wvqh/1mvSzeITYiqtpv/ng0b
	zOSDyRQTBNqFM1EJpX57IuZBYT+WfvRtd6B4fTLSBgPxREZCt/igKcG8A4phqyMwKAGxVBdDXZS
	w92U6rusndqQzZdQJW/lgGBzgUAzBjpEroAZerIMc/V/ZNzd75agjlZOlK9F075QV5d1idAKXDH
	VUqJXR4kB7L2HLM9iAtHyU8do4goAL/uPjXW3PKBSzvI4a4n/301cWOSX2x5yBc9xTOyj6IUyv8
	7Tj7XZ3WX1yf4DwP5z1DqucjkkMMAJvhoF1Tk026k5pD3LSHXV78LNWxQZGJy9Vs63ej1UBBXYc
	sOBhgeghhWCogGVCJKAA==
X-Received: by 2002:a53:cc0e:0:b0:64c:9ec3:d70f with SMTP id 956f58d0204a3-64eaa8455a3mr10425256d50.71.1774296934605;
        Mon, 23 Mar 2026 13:15:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabbf8503sm6713454d50.0.2026.03.23.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:15:34 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC] generic/301: flaky failure on btrfs after metadata overcommit change
Date: Mon, 23 Mar 2026 13:15:29 -0700
Message-ID: <20260323201533.2648753-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,=0D
=0D
generic/301 has become flaky on btrfs after commit 0dc118b3c327 ("btrfs:=0D
be less aggressive with metadata overcommit when we can do full=0D
flushing") which landed in btrfs/for-next. Out of 30 runs, 8 fail with:=0D
=0D
    +file2 badly fragmented=0D
=0D
I bisected this to the above commit, which reduces the metadata=0D
overcommit limit from 1/8th to 1/64th of available space for=0D
full-flushing contexts. This is a legitimate fix for -ENOSPC transaction=0D
aborts on small filesystems, but as a side effect it causes more=0D
frequent transaction commits during writeback. The reduced batching=0D
means the extent allocator has less opportunity to coalesce adjacent CoW=0D
extents, resulting in higher extent counts that sometimes cross the=0D
test's threshold.=0D
=0D
The fragmentation check in question is:=0D
=0D
    test $new_extents -lt $((internal_blks * 2 / 3)) || echo "file2 badly f=
ragmented"=0D
=0D
The 2/3 threshold was introduced in 9184ca155d7c ("xfs: test=0D
fragmentation characteristics of copy-on-write") as part of a series=0D
testing XFS's CoW extent size hint (cowextsize) mechanism. For btrfs,=0D
this threshold is arbitrary =E2=80=94 btrfs doesn't have XFS's cowextsize h=
int,=0D
and its CoW extent allocation depends on factors like transaction commit=0D
frequency and metadata reservation behavior, which is exactly what the=0D
overcommit commit changed.=0D
=0D
I see two possible fixes and would appreciate input on which is=0D
preferred:=0D
=0D
Option A: _notrun for btrfs=0D
----------------------------=0D
=0D
Skip the entire test since the fragmentation threshold is not applicable=0D
to btrfs:=0D
=0D
    test $FSTYP =3D "btrfs" && \=0D
        _notrun "CoW fragmentation threshold not applicable to btrfs"=0D
=0D
Option B: Skip only the extent count assertion for btrfs=0D
---------------------------------------------------------=0D
=0D
Keep the CoW + data integrity portion of the test (the md5sum checks=0D
after random CoW writes and remount are still useful) and only skip the=0D
fragmentation assertion:=0D
=0D
    if [ "$FSTYP" !=3D "btrfs" ]; then=0D
        test $new_extents -lt $((internal_blks * 2 / 3)) || \=0D
            echo "file2 badly fragmented"=0D
    fi=0D
=0D
I lean towards option B since the CoW write + remount + md5sum=0D
verification is still a reasonable smoke test, but option A is cleaner=0D
if the consensus is that this test isn't adding value for btrfs.=0D
=0D
Thoughts?=0D
=0D
Thanks,=0D
Leo Martins=0D
