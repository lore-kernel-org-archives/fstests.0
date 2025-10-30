Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AD255F28
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838217; cv=none; b=V0wCBZZM41areCZKhDPrunarOa7rjvpsA4SZX1PXcBSuCP7KQpiXm3bfLJt3SQc0pcTytka8qcjs/Wc7uqat/Vzf4VooQf17ZfAgMVqLNHL4yh7KE6ITr8Y14QUN3fcuj6cGMrr8mBpujnrEBMOZ6ax9i9zo9j6PBin9UOqdMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838217; c=relaxed/simple;
	bh=wbatvSc5zqDCLsj2CQf601+pVeXE6nWgp+jdwAsun+E=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q2Gw08LT3igNZDYe07HEN5jJMBmDhd+P9T6GMqxRwE6eI35c4GuRhwmILZ0EWGqRZNqjEMFijNw5dVs7k2XIaxYCCND7+2UfMT2jplR3gSfCsUaPHBIU2v9O0sn/7OUEuFHSSQ1xY4Qi2mD7AP4pzMRChWhUZNkvJchpTJfUpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCXxg/Ci; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCXxg/Ci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761838214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/iL0E0FmuuTFitLOn8c1GYACVCMUBSGpnSgThi/YTLs=;
	b=TCXxg/CihxPH0pk1B+wL+UXgZe6IIrjYMeP2OVjz4Zq3G2zfaQiGfvkIgz1tOsN5wixJMD
	qj71WCGNB3zT1CnOcOptnrtNv7fq+vPFCXFaLzbBRedXB7VWw/gQcoIowFbH23L0GuzyLM
	XIyBvW/UOuamnZm/E0P6VsBAx17qKc0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-rCzkjPLGMharfhGodiX7AQ-1; Thu, 30 Oct 2025 11:30:12 -0400
X-MC-Unique: rCzkjPLGMharfhGodiX7AQ-1
X-Mimecast-MFC-AGG-ID: rCzkjPLGMharfhGodiX7AQ_1761838212
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475db4369b1so6346675e9.3
        for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 08:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838211; x=1762443011;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iL0E0FmuuTFitLOn8c1GYACVCMUBSGpnSgThi/YTLs=;
        b=aVuQoTXy2PdYGmkFSdGl3TQDSAdBq7+rW0Wv/ux891uD0BDwzohXkw4F9y6X4ND8ck
         oNWiTSk6J6MMzh43xdwnPV2D7UUB2ha6tr+y+hwKJ/6rvgdH7dCZhd/IN9ddMCsQt/AH
         rLc033CViWhvGJ9DoDoUgLYF53JsixzWgIMw/RHdfmg8TpVQtKxXmyy+LcRuo8/6KDL/
         UMu+gXSuYj6ixZ0baV+Y47WXHfb8mC/CJ4WBz0KNWMbJhJHCcvNXuCAneYr284reMMMV
         s3HBOyNg2unBslUxqt4kb8UC8dhVyTBbE/z1qj6CHoOgDuCSwAeRTzBWPCTpi+NqDV9+
         gVCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1qxSuSReLXL8qByEBoGZ0jfriWou46BZQ4ADZ3pteyJMQgqN9emCUW/xikCAzxpvbGLafPJSW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn46ayRwiRsEwctLwRmQ+y73JVGEEzyEDGPwC1bXapebKPHfAe
	FKzJYBSGvgRzRUxnkINSp4X3TAdzElyDMXFZ9UF+v9IjmiSZtCfyi4VBy7IU94MUn76BmhOgI9m
	7u8PcyAeiwyKkD/yfrHKTqV3YBkEwKXMbBmUor7ortttbJZoLsmltQRH6ZA==
X-Gm-Gg: ASbGnctptQVzsMHny9Hh/R2hqo02t8HRtWJ+pB1hk4lRbyF0jLZOmoYXh264UOvfv6b
	d+AdYQqxSC7LlkX/cM79jTzDOrwFg0a3GCj1xw3hFcola5MZ4WhlItQ21HgUHapM9lgYV9NbWmb
	vZ9zxfGfeY8pWPDiR4CB83vL+CUXxj8y72uLJmwcwwNCv1LzPAjb/kKkrP9V4RmVOAcVD5ZZBpj
	/Q2eMUzsHzHJGJP7hbmKGheGBoi0spFJ/2uy1khHrlMjIhg0FkLp1MxVTJtwIAoUzFdbZkQi/kk
	yPpbupGEpKJYHgTFPO1R7wOLbU3CXeAixT3W8jQ3H6mhhKd9CmnkO0yme6Dxc1H4
X-Received: by 2002:a05:600c:348a:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-477307c22f5mr1481675e9.14.1761838211291;
        Thu, 30 Oct 2025 08:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdX7mCIVDw0C9uUK3AN9nI48uZotQy3os0Sj+T8VNYaeCSFY7AB89nkb+OVP5I9mc7QHBaoA==
X-Received: by 2002:a05:600c:348a:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-477307c22f5mr1481105e9.14.1761838210681;
        Thu, 30 Oct 2025 08:30:10 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm32400420f8f.43.2025.10.30.08.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:30:10 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Thu, 30 Oct 2025 16:30:09 +0100
To: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, zlang@redhat.com, 
	djwong@kernel.org, aalbersh@kernel.org
Subject: [PATCH v2 0/3] generic/772: split and fix
Message-ID: <cover.1761838171.patch-series@thinky>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This one add one missed file attribute flag (n). Then, the check for
file_getattr/file_setattr on regular and special files is lifted to the
common/ for futher test splitting. The generic/772 is split into two
tests one for regular files and one for special files.

This one based on top of Darrick's "random fixes" patchset [1]

Changes from v1:
- Remove patch which added file attribute as it's now convered
- Use TEST_DIR instead of depending on SCRATCH_MNT

To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: zlang@redhat.com
Cc: djwong@kernel.org

[1]: https://lore.kernel.org/fstests/176107188615.4163693.708102333699699249.stgit@frogsfrogsfrogs/

Andrey Albershteyn <aalbersh@kernel.org>:
  generic/772: require filesystem to support file_[g|s]etattr
  generic/772: split this test into 772 and 779 for regular and special files


common/rc             | 32 ++++++++++++++++++++++++++++++++
tests/generic/772     | 41 ++---------------------------------------
tests/generic/772.out | 14 --------------
tests/generic/779     | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
tests/generic/779.out | 20 ++++++++++++++++++++
tests/xfs/648         |  6 ++----
6 files changed, 142 insertions(+), 57 deletions(-)

-- 
- Andrey

