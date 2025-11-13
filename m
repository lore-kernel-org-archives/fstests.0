Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D62320A0E
	for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034559; cv=none; b=MQCprXhQasbflRiudBlkkCE9RJ16fRSq7yeY2wjxuL9QZl+XezDyWnMr72QJQO9899jSctw1KiERNzKGPnvG9m718GujWOQGzjdQ9xx9y61B7TWkhyz+1HlnzKcSvJjY+tTdroQo/flDr0a/PHYWi2U3JcXOrDSOpjUBGTLoeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034559; c=relaxed/simple;
	bh=kD2YUiGDbyiYlq95KJ3XiI0c1LAn1KcgrND6++o0tsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwqvrOc2ANzEGRKBz2qy9/Za8rFbNk/e0+CGARhDIvA6id07EUZlhtH0g/f370JSAJ3hPSHpQQA0Wyj2YVIzPPCR1+y72Mo6fzhxLkO92bSOn4mv6DPn7sbuFw/mKN9enshqRgPIAbSUdKHwMs+Pk0XM9HC9RLK+hHCEziLVdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKkSmllQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9BItQpc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKkSmllQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9BItQpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dabx+6EH/9u0kdFwkmBGsgarWdsFVWOkofePnXGY/+M=;
	b=CKkSmllQjz3MWq+NrzI6nn2lrUwJFjSErny6L7RKyxlpWUUxwyaheCt5PKwmLbJD74oWxl
	4Yl351MKweQw58eism9CqXte8+yHAPLU2nKbHKpwcfTtM8AogIEPVoOdwxkKGULeShWgJ7
	9yzfq9EpQJwz+bPEwnDq0X8/b6vvM+Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-ennZH7SDOx6Hlig-GQaMsg-1; Thu, 13 Nov 2025 06:49:15 -0500
X-MC-Unique: ennZH7SDOx6Hlig-GQaMsg-1
X-Mimecast-MFC-AGG-ID: ennZH7SDOx6Hlig-GQaMsg_1763034555
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89090e340bfso160817485a.0
        for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 03:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763034554; x=1763639354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dabx+6EH/9u0kdFwkmBGsgarWdsFVWOkofePnXGY/+M=;
        b=G9BItQpcsZqOiwKuhX4A1oD69BK74VKhllH0YBb3wbISPpyWXjgcNIDDpad2MjMQ3r
         0gZfXpUV3+sgXTd+ZijWpsiqc7xnEEgCElP19jFLSkLghlwwf1HvS4H1E/cBaQiwrw7k
         55sZ+tB8LATvD8WvqNxoPNofoYn54XzvDdaCMiThF9KHrmGz6Jpo/cnm6zsuDh8X462y
         Ke6RedOwBxNVZi9itrXZq/BZnyHhXNdw/wnYaUp7K/sbfBS+8DdcorSUbCZXxW9IgOMe
         tod2tYESZ4SUc2QNkqBJ2SI1Xnpl95gP00cKxaHxCUytVtq/dn0ySjoH4aQcT6NhwJHY
         0NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763034554; x=1763639354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dabx+6EH/9u0kdFwkmBGsgarWdsFVWOkofePnXGY/+M=;
        b=F2J12jmaggqYYLUW5uaOLvLAN9diAeGXbSLQcw2t7Vk5zDZ1Xr7j1CDinAYm2N1CN6
         2+VMp1qol5u2G7Y7im4ZXpwpaZCOaeStDptGfCd5zy0uh16vhaACr7tbvxxQq+Uga5Yb
         I4B8uQBCkjg5eujctbFCIh4qMaZ7AhYIhg6/cVCrpw7OHZsfhho2C5ekzAEA1reN33Wa
         rNzaJWrIoSJElvZ/f4fJnhXOS2UGWxs2SeMZIWiHCN3PN15sxL/QpKkh2cSTiEXy+P+Z
         SA9V2LoNZqX72ZxfCsglC9bOMY6hvP5UDhnPmq7CZb9mwBuOLUrA4cEiKUdGf8lD2Jc5
         SHzQ==
X-Gm-Message-State: AOJu0YwZwUBhI9vyBxGVhMW4fXdBkEvvkss0okoglJbS27jZ+ruGevHu
	PHHF4rWL31v7Yqj6pPaenE87b3FkYrrNldLTuxeq+YFAyO40TeXK5iCUKT12gCCzCqYpXM8ALMz
	oZkQFANvQmQDBSzRWVbGY6ljhoMoXzIMmizYxSanoSZqo8em28rjqp+7kBTa1zRZ6I8oDLYI28/
	cqlStC6v2Yhxw+3998HOnZvC4xRMveOvWtW5mGhm9DuHeGxg==
X-Gm-Gg: ASbGnctDgD4W+nw5wqzyJkk6t0caxzI7FcHsv9X6T8eekgDKnaxikdsL8sZbokFQzX2
	uI60uB3xbr8MBxU9uT38iEM+ZnSFjzhl1hrQhlwNNVloP0xoK1uG/fwnElgxRZRHa8MbdBDO3Be
	McNGYYdha1O5M6TajbrK52nwC8+7z3LFa1PNMUwBBO4FcKWu14aQMwZ8p1d+jCeBT1jpI1ViuS1
	kFDFlna7mTwckJeeictyZAL27m3//CGF4F3JLaC5khEKBgELIGTjWmQ+Xh5AkwDJv9a2o5Kflki
	CgpJL/Jd0w9m8hYFg8rjZZpTfOn56s1fz8sRCKa00Cj453oO9WaFGnlv6s1VFMpbbjV+Dbg=
X-Received: by 2002:a05:620a:31a9:b0:8b1:d8f5:6d08 with SMTP id af79cd13be357-8b29b6bfe69mr857722985a.0.1763034554131;
        Thu, 13 Nov 2025 03:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCujXnMoGDEbn82bw5netCmOzgaQDPeWr1XPGjXtQkTXAXAi8TWqf4lbYKGWBl5tUXYLS6XA==
X-Received: by 2002:a05:620a:31a9:b0:8b1:d8f5:6d08 with SMTP id af79cd13be357-8b29b6bfe69mr857719285a.0.1763034553571;
        Thu, 13 Nov 2025 03:49:13 -0800 (PST)
Received: from fedorakvm ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af044e3asm110330585a.41.2025.11.13.03.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:49:13 -0800 (PST)
From: Ravi Singh <ravising@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH v2 0/1] README: improve README formatting and clarity
Date: Thu, 13 Nov 2025 06:48:52 -0500
Message-ID: <20251113114853.609289-1-ravising@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112181859.GF196366@frogsfrogsfrogs>
References: <20251112181859.GF196366@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch updates the README examples to use the root shell prompt '#'
instead of '$'. This aligns the documentation examples with typical
shell conventions and reviewer feedback.

Changes since v1:
 - Replaced '$' with '#' in example shell commands
 - Addressed reviewer feedback about correct prompt usage

Thanks for the review and feedback!

Ravi Singh (1):
  README: improve README formatting and clarity

 README | 70 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

-- 
2.51.1

