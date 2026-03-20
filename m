Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273037FF7A
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022214; cv=none; b=Zm57DmNx/oXaaIgVPrHGV2sX7/s7dGXCma6x+cN/IIfWd91NmwWPviWn2EtkdmeoLHtdzcIqg6XVZ09QJkQ2p7QTOlzXG0N0R0Z/yWeNyST7Yi3jxKiCeTsDbv+UFFF7ENLscqdFBPe1QHMtr+JvZXqjLyMaEGvuL0aqi44Zgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022214; c=relaxed/simple;
	bh=LQy/KCE4ucJHFDosSEjlvsVv3FC/13AGUH0HF4liaIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk0h7DhL8/dqKaA0ap4iTWlERBMDC2X4gpBzVM9E9utXD/D8WoeXyshEvYB5u1oRGEZwbRsEooT0HuhqbfvbmJN2aW3K/E7ha2l1Qzq2MdNeORO6Wv7iwVkfeHgUuV1VBtQAVBuEnXV0b1XEDmrI69iko7NDrDL/ZGFAcpcWIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTOFinkZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFPDabId; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTOFinkZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFPDabId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774022212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MA+CRI+2HGuDcIcARJbsDHYO24X4vy8CXSMYPvzTCKU=;
	b=jTOFinkZDDEQ5G5plwhQKcGom6CDEaT2tBRaW5v2hZ9CCw+2cKQxV1V0eVNKU/BgOS6iXp
	MhGv441qb4i56OtVjxOrOkQ2U41ZtrCs/sXnSYZq5ybtyjJBD8UQptD8kPmbdqtTrPD8OF
	47UmyAy/fApHOnobKoHwyRglf4WsX6Y=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-VtpeYUTyOeOKxM1Sob3SDw-1; Fri, 20 Mar 2026 11:56:50 -0400
X-MC-Unique: VtpeYUTyOeOKxM1Sob3SDw-1
X-Mimecast-MFC-AGG-ID: VtpeYUTyOeOKxM1Sob3SDw_1774022209
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso3063961a91.0
        for <fstests@vger.kernel.org>; Fri, 20 Mar 2026 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774022209; x=1774627009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA+CRI+2HGuDcIcARJbsDHYO24X4vy8CXSMYPvzTCKU=;
        b=aFPDabIdbByqEP0BhWrhBHGuBvntPPQMxPlAYmpAnA34Aq3GGrnFP5M0fZkNYJOAhE
         R/G0jHtanzhL1dADy174T6rFBdsj4V1I3DNuHEBNRmlxCglIX2kxZhleiaD7DorLvfWL
         Dng7TcN1VyjAtg17NtOPjhb4jdqqvHxNpCx8U9SBjdzdP3/zn2rwndWA8u4pcZMvHH5s
         SDkfymnndeRuyayogcKOxooZdhm+KzA7WtUJ1nrAgndUR3R4crX9DaqcS8XDKdhi1epf
         dQH/37XORZhtC/i84wV8w8rPioMxs253qqGhwf20Zb45NWbQvis23IDOWfMReC9sCw9L
         ijZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774022209; x=1774627009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA+CRI+2HGuDcIcARJbsDHYO24X4vy8CXSMYPvzTCKU=;
        b=djpGlymexZSWB5ojnr9IlGvbqdqOjBYz4pm+G2KSFkyK1MBfov13G1UsM79phWPfkm
         jY7P28G9B9ulWeAzhnz5vaZaJzn9MPX3Olkk+B1mfE3diRMbN7zskLkt7ym8ic3ri8r4
         2kygHuYxMTQBPXc3xxMs9GOyISuaoqpBzXC800C+YBw5DTZXf+KkyiPPsQCxMwXGkm1l
         /WuJUr5zGfBex3BxqSpeLFDM/8Rf8WXs93nTPzlKpTS2Jk26u+amnN39pFakzCT8LyX4
         /wkIU431SaWPz4thVFAnetuv3hkhuvc26+HNcybQeVlGAzYHRYLmHumhvhKZIPREwU19
         4fUA==
X-Gm-Message-State: AOJu0YyqFbFQPsPeNPYjlOEqXkBowhL6rZzE8gJlWn53jk5vXC9hxWA8
	yMb0CAewM23JJmZ/xAx5GbgExMcMaBNsnJXqzk936b48EvtUs0qlLhqXOXqEAJTdcdg7PQvW5k8
	1cpNSMVyXEHNPUyZ3Xcde5sk/BEpSlc+ycB4fJ0FI+aPZUQqTyYY3Lg8UqIM=
X-Gm-Gg: ATEYQzzm8h6EO+eZbK0ATlXv0Tj5xLEjb46EIJrz4tMtyJuu6JQDfINTmQaOV/oa2qd
	9+LyglX5/iwmsfVxFK/Qxh7fhU7ha9QFhpmqkKO5bQfIwP+wbnc5gEyNqGZPNHjTpQWAyrRpmRP
	V+yU88vsM6n/ExPs5qAA8ggt5hnlHTpc5JX2yQq2fGSn5vByfXig4Ev+hOtm5NPxhLX4REx1Qeo
	r4yQcFbsSmCoJgKNCqVsinetVb/41hFbp9XMG7xrXjrUFrG3QJ0o2YZi8D17tzCm+xv6FXCYUKM
	9t30dMjRLshPGwvhYCtAXW8s6k/yuACuIatY76bdQ70APv7gD/F9fLNl0OrrhdEwgbGqWkdCFsH
	cLiIhwjV/5/7VdyKv6g==
X-Received: by 2002:a17:90b:4c4a:b0:359:1821:b4d5 with SMTP id 98e67ed59e1d1-35bd2bbe429mr3012663a91.5.1774022209451;
        Fri, 20 Mar 2026 08:56:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4a:b0:359:1821:b4d5 with SMTP id 98e67ed59e1d1-35bd2bbe429mr3012646a91.5.1774022208937;
        Fri, 20 Mar 2026 08:56:48 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb46e3sm2282169a91.1.2026.03.20.08.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:56:48 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:56:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] generic/730: skip on ext4 when dax is enabled
Message-ID: <20260320155644.yy4qz2ulujpppaj2@doltdoltdolt>
References: <20260318081812.47870-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318081812.47870-1-disgoel@linux.ibm.com>

On Wed, Mar 18, 2026 at 01:48:12PM +0530, Disha Goel wrote:
> The generic/730 test utilizes the scsi_debug driver to create a
> synthetic SCSI block device for testing. However, scsi_debug does
> not support DAX capabilities.
> 
> When xfstests is configured with DAX mount options, ext4 strictly
> validates the block device during the mount phase. This results
> in a mount failure:
>   EXT4-fs (sdc): DAX unsupported by block device.
> 
> Skip this test for ext4 when the 'dax' mount option is present to
> avoid false failures.
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---

I think this case isn't a DAX related test case, even give it "-o dax=always",
it won't test scsi_debug with that either. So why don't we simply skip the test
if dax is detected in MOUNT_OPTIONS?

  _exclude_scratch_mount_option dax

Any thoughts on this?

Thanks,
Zorro

>  tests/generic/730 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6b5d3196..b42f5f63 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -20,6 +20,9 @@ _cleanup()
>  . ./common/filter
>  . ./common/scsi_debug
>  
> +if [ "$FSTYP" == "ext4" ] && echo "$MOUNT_OPTIONS" | grep -q "dax"; then
> +	_notrun "ext4 does not support dax mounts on scsi_debug"
> +fi
>  
>  # We don't actually use the test device, but we need a block based fs
>  _require_test
> -- 
> 2.45.1
> 

