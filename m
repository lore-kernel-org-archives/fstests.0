Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC413E886
	for <fstests@vger.kernel.org>; Mon,  8 Apr 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588166; cv=none; b=UhiYSZa9scPVSFULQeY3h/986YETuQ+njzM2egmWDyzE24MxLxK5By+pHeaGkr5+8YOu509sue08J66KrQAS4RUOaLDiu/kwUvQRINndjUnTCgX1IYpe9gtKh1iKl/CoQdGRn8/roDuzkFs+Xd/N8ukBJ3cJMk38YXr6XieJDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588166; c=relaxed/simple;
	bh=sKRkk6UorXV2/hWmh9SiDbiNf3cFzww98iE80iM2CIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el4q09nih6abFc8edVcjig7OZ6ssulvq22hb7+XMlWino90ZroK+3tgvd3vKPWWFvqsZqaNuHxVoB3ESOzrwUq7o3cv7PkoaCvC/euvvL1XjV9idPpP0GVTrZZ4crinv6UOiev7s3kpiLEHHeQq0Hz+s+tWtXR/mT1gq26Hb68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoM3nxq5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoM3nxq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712588163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LyxVVyuhaB0KgaymTkcE64U3/nIUg9t4q/715To/SQM=;
	b=IoM3nxq5j5Os5wW+kP7MThjzxtTsRr3fCx2LCnFVIcsAS0BpLB3vIt8t8o2eXYZlEeV3gO
	Rj8qAjeM+9hbX6r3V13lB6poq0gtUhFgkhsU6qPe5NLSO47VdTyZm9dRs/SW7xi52zNK4R
	kwrHQgR6ijfrYXWu4oF4IN2VsX7LZ8g=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-tBGO6kdeOHqNBDuHIs_B2g-1; Mon, 08 Apr 2024 10:56:02 -0400
X-MC-Unique: tBGO6kdeOHqNBDuHIs_B2g-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ed03216b70so1840260b3a.3
        for <fstests@vger.kernel.org>; Mon, 08 Apr 2024 07:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712588161; x=1713192961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyxVVyuhaB0KgaymTkcE64U3/nIUg9t4q/715To/SQM=;
        b=gjK5zrYYUlvMZN1hIOivk+RcbUAFTwqySPM0IAxyh9qt0WMexIGEZpkhswlT4zUKZe
         IMXkRYU/f+ZT5xpgJDGacpHz1ejJfK0EzBElQS3yvuz1YivRMk65Hc2LsCKWbAXn9oIv
         dRpPa+Ge/scmBZzRGqK4hWTBCXVR36cft1vLMt4iK6YRNAxWZ4n9ae+6oAwKqOezQosL
         F/GfAVHitjadg+FwNyLkyhmIikPh3xOBVvSlB+3pVIOn4SsvAiAmWFN1EreWphy+Kjlv
         eZWzaqxiDgFJmtpg6DjheYsrJNzGYjpx5GQP636R2bUcMXTjnoW/6Rss2SsE6t5UTRkF
         qIUA==
X-Forwarded-Encrypted: i=1; AJvYcCWri931GdAsHMbsKvBzLp1+uiHt4bzHuooNlJ3DsQgU0CZ54t8MlAkL0f5tgqPSTfs4zP+M3dDzVm9xXJYfnrTvVXvPoXYDLA==
X-Gm-Message-State: AOJu0YzEhlUzHM9NKZEsByfWEYAeLn2wnIkTkSnhK/EdkyFGdQ38fDa8
	uVC3Jw6aE+lsT27QaCjYHWd2pkw+I8BgkRA+LKdyUnwCs33Ak2DYPnqFk49WLJe7w2n2rcW7hvM
	YrX2cWyKzogKWgh1JfHaliu44oEz+41Qwk8WO3cvE/cANWg6Qh3uoPio=
X-Received: by 2002:a05:6a20:d497:b0:1a3:df1d:deba with SMTP id im23-20020a056a20d49700b001a3df1ddebamr9524230pzb.31.1712588161124;
        Mon, 08 Apr 2024 07:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4kUivFSxO9oiwXu3+PWw9VOhuyMbHjta1nuDXWfWzJJnmB3FmGliXFYglySoc98MdcGr/ew==
X-Received: by 2002:a05:6a20:d497:b0:1a3:df1d:deba with SMTP id im23-20020a056a20d49700b001a3df1ddebamr9524201pzb.31.1712588160635;
        Mon, 08 Apr 2024 07:56:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fe9-20020a056a002f0900b006e5571be110sm6603606pfb.214.2024.04.08.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:56:00 -0700 (PDT)
Date: Mon, 8 Apr 2024 22:55:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J . Wong " <djwong@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: fix kernels without v5 support
Message-ID: <20240408145554.ezvbgolzjppua4in@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240408133243.694134-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408133243.694134-1-hch@lst.de>

On Mon, Apr 08, 2024 at 03:32:37PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series ensures tests pass on kernels without v5 support.  As a side
> effect it also removes support for historic kernels and xfsprogs without
> any v5 support, and without mkfs input validation.

Thanks for doing this! I'm wondering if fstests should do this "removing"
earlier than xfs? Hope to hear more opinions from xfs list and other fstests
users (especially from some LTS distro) :)

Thanks,
Zorro

> 

