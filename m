Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047625B68D
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702171; cv=none; b=kXJMe8xqSbWh7n/A7PPtf352Pv6xT3VM2/u/3/+EoHsCWKCGNZ+LNJSP/YdaRxHr63UyryveHKfkot/LYRkeJTqKNCjEtSgoJ7taPUkAZD/nCKSWNM5Pt/iIqTbxOCQ3zwcI7hSLqQoLiXnLdPT8/LU5E+U9J8dpXVHEOcZ7h3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702171; c=relaxed/simple;
	bh=jWr4Qm7qootQE1IuB4z6zf/sIKlm0MhPhBadWgR5bxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyRpI6UHxBhdU5F+tuQH08A09yrn9gri2/6/NhHIYkX2e9VKDnD+Gh0JUULtgZoYrw/5viDPHfeCnt/Q6XCblCdL97QtiBPYmbuhdw9QKxYSbhGLLI8iJ00LOnb0TYM/y1gNRL9JhjvRqvbSwTM5kB9PwDh5ukubwsJyzwjP9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ6vO8AL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ6vO8AL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741702168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHN+WyTXC9cTVt8Szj+5ZB32yaeO7+nSt9V6FrdnRtk=;
	b=bQ6vO8ALGigRZrcptizNsaX9sF4Ut/zY9mg4d+P62gT32cMLZVJbYtB4vMNNHF+BTfc4Cg
	li/87CLTOdpTVN840Mo+WAFgll/NanWHDBaNXuxnNfOUWuFGKfFu45kYthFLx9ll11FtQd
	p5+gFmWgula6pOaoRvaV3PoB0WcmdpU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-Pid1ZAr2MZmQqEfXBIn6nw-1; Tue, 11 Mar 2025 10:09:27 -0400
X-MC-Unique: Pid1ZAr2MZmQqEfXBIn6nw-1
X-Mimecast-MFC-AGG-ID: Pid1ZAr2MZmQqEfXBIn6nw_1741702166
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242ca2a4a5so54054445ad.2
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702166; x=1742306966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHN+WyTXC9cTVt8Szj+5ZB32yaeO7+nSt9V6FrdnRtk=;
        b=v+IsOuyZ/C+IHGzdhj10/jEZDqWSWyWnHjbNgJNVz7ep5M0hEYEQWd3f2jDmlgi1NI
         9bt9DH+gbdoCbuPr6jNbCGS8aQBhSZhC5ly7+T9v64baGydbgbIpz5pQ1IThRCnMb44P
         hyl+H3O8bfHBJF4+bMCfLl2hckDj1itvwxtR4+6zGgxLSxx5pDveBQZJuJe0Uh7iEDSN
         UfSKROzPg7oYSFxUweAvrKHBpU+QZbOqofpLO0ny8svktRk3a7olKA236ur1t1BtYx6E
         tvR/pD6Jjk8dp7nWdW9J+pXiawUAyZVf2jp1EfcpI4pW0Ui77EIK4JAD9GCgJxBWFnUx
         S19A==
X-Forwarded-Encrypted: i=1; AJvYcCXXELSAunI5gezG1COWIhWxib7Ld9zCos8quOYVMyvNv7+QyZ7dq+SBS7asxETDFFye8gDIk3AC@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCd0YS/sax3xM7N+A+yXt1fCE5EHfgGKkYtnKSSPguSqc6D3Q
	9IaNrlrpbfgLxTjzvGisniQJw+hUv8t3SFQW5kkfqCxnkf7z8iHRlgWRjYLd6KDC5phmZU6iDHt
	djweQkAgPzU7kHMS/qUVJhRsxjdurEUzhcXBbqJQXXjRMSfDz1uILLLg=
X-Gm-Gg: ASbGncu1RKXyeZpaFaoiGlKEkpaCYCqGEQd2cRIUXDOrQ6/6b42NpgDnYNcCZwjE2lq
	k4/CsilQDwyxTOnE+XUFKBBGOd3D+MJkEKLvJDSTfHWaHEjI4z6iqgX8JcyNEZflr7F/xw9F8tS
	s/5JobX3O6YPI5pSpQzyd5rZxNE4Qf/aZvPnjCkoph+6x8nSG6sD3yjeM72oqqX2O2y8NVXok6I
	vNSghG5MQOAMJEol+6PjmkYP48umcTcCTRYR/Jb+Y0tQEYxxbXPWtF8IK5FK7uWWO6JtulJ91+6
	STSoWsZaa04tP7ceXRpgEWMPK8uWArZnctrT0jYnlttOdBbtMK6Snpgb
X-Received: by 2002:a05:6a00:27a0:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-736aaae81dbmr24406301b3a.21.1741702165932;
        Tue, 11 Mar 2025 07:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwRe8L4LDh2K3HMdnKilzZNO0IeGk2PElblD0WViJm8ydFFUjXMlOdlQ58DkPx2DHiK9Q+JQ==
X-Received: by 2002:a05:6a00:27a0:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-736aaae81dbmr24406271b3a.21.1741702165614;
        Tue, 11 Mar 2025 07:09:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736aead3439sm8716245b3a.64.2025.03.11.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:09:25 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:09:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 3/6] common/config: export F2FS_FSCK_PROG
Message-ID: <20250311140919.5r4vossfrose2w2q@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250311080430.3696582-1-chao@kernel.org>
 <20250311080430.3696582-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311080430.3696582-3-chao@kernel.org>

On Tue, Mar 11, 2025 at 04:04:27PM +0800, Chao Yu wrote:
> Let's export F2FS_FSCK_PROG, then we can use it in
> _check_f2fs_filesystem() later.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Although patch 2 and 3 can be in one patch, I don't mind seperating
them if you'd like.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> v3:
> - export F2FS_FSCK_PROG, and it will be used latter
>  common/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/config b/common/config
> index 7d017a05..79bec87f 100644
> --- a/common/config
> +++ b/common/config
> @@ -317,6 +317,7 @@ export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
>  export DUMP_F2FS_PROG=$(type -P dump.f2fs)
>  export F2FS_IO_PROG=$(type -P f2fs_io)
>  export F2FS_INJECT_PROG=$(type -P inject.f2fs)
> +export F2FS_FSCK_PROG=$(type -P fsck.f2fs)
>  export BTRFS_UTIL_PROG=$(type -P btrfs)
>  export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
>  export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
> -- 
> 2.48.1
> 

