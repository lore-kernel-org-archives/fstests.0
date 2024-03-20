Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9571A291
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945666; cv=none; b=cWrVslgT7dYpQvnGrkoCitnjQlwvr8Y2cUGmktHU1pBlNSRkwMhtUaF2S5HiAeNS8LwlZzkdmttAmrI+FpQE56OaOlqPQ8uSr2pbVuO/INp7uvAoaVB4cLX+26LbhS3mbGwYuFTlRrx9AhqwPIg66YI3/jvhB358p8xsXAojblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945666; c=relaxed/simple;
	bh=Id4vIZ5YkSyk5Eyz0DKkkvd7gT1uzKEp+OA3sRCvh9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjBltnpVtV21b1OjiPVtNgBDoDjQcndG9AiwvMTvDBj/a81oXZjV3uTweOgAOycGdQ4owqwr0EonfWt/Ky0LjPhlMLSIUYuH8o9Y3v+7KiseOGGspfbP+kgdCoAD564NtoPxV4AHy7RYYMRoqcivRAOuyx28KKBKKZIrADFFEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iXpUveqO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iXpUveqO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789e6ceaff1so91969685a.0
        for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710945663; x=1711550463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzhRDjzSwtUT89GDDPVGCRpdCdyKu+q+6CD4rkGwqBA=;
        b=iXpUveqO3aHUFTgspQYI9b5NVPuT+/70qLz+H8HB0U6JckJeaEGbuCuoTYUWeoYGh+
         WyQVMtlFawu6zmSXy/ilAmnV7fOjktPNtR5TSyEHzcOSIiqm/T24DovBHIoPwKV0zcrV
         ogKUnOpuh1OFxojhs5RtaRmQXv46iwSqNYi19FhJkpZkkVXglXPRSomD9Jx6X1m2cj1K
         5UFAGFOkHyUqvTQUfNQXFqwnH9g1WnPCNBFrZlMztfZC8PCMdfXbFk1vdjZjwHZ/M8QI
         JsVx2YJfjxtTutAWfU/oIbEXshWku04aEy0jl5ofzEe0HQTfArqH3+YgvQP1lqnma1Y4
         3gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945663; x=1711550463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzhRDjzSwtUT89GDDPVGCRpdCdyKu+q+6CD4rkGwqBA=;
        b=SB+NcaKeSAZmeGdwCAN7j52crjF+YBKsqLIYP0H04YvrfBqvuvPEz9vFFhgAG1bo8r
         Ovq2FyZfCN3Y+8HuyXyPBR5kEr9WiPQKPgISearnJxFnjH4Y1WFkF8ykoHUxoK6cAnv7
         oa4ViqG9sk057mbjLByng2wxBJqHJfRCfB7Meem8yYQWEoyL9tu0tTL5xFk0VfgHjSeI
         E9+8T2ZQpdGiiWfSIiKR6TLrHnXB1jXHqnLjQXKnXRUsK+Z0LgrZnXd5fhKWtU3sUcbp
         QDLyVcWNmS/zVmDcO+bOz5bmVYgpkikNtQuBSv1fFAHl1k7bxeD3PepW0yX9Kv7+ECcJ
         9N6g==
X-Gm-Message-State: AOJu0YxJDR8MiD2OMjzTpSTClHIWWxwm/1kiz8w2BJQ+qe3TDbxAZxdZ
	AsojR8wRnS8OYZJWvLg7fCBAUwHu1RLOeSGNsNx0jK8cMUgxjR6F5capF+eShiM=
X-Google-Smtp-Source: AGHT+IFesBG393Xp7ovtOT7jjGKjyrwrODpAizXO+vDMKdSjHJvJPo9L3rPARKzXR9QEV52lJZMXjA==
X-Received: by 2002:a05:620a:24d3:b0:78a:1ebf:12d with SMTP id m19-20020a05620a24d300b0078a1ebf012dmr4486997qkn.16.1710945663512;
        Wed, 20 Mar 2024 07:41:03 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm6631607qkg.70.2024.03.20.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:41:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:41:02 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 1/3] fstests: check btrfs profile configs before allowing
 raid56
Message-ID: <20240320144102.GC3014929@perftesting>
References: <cover.1710867187.git.josef@toxicpanda.com>
 <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
 <343344c4-7a12-4e58-84b9-6b8a7ef51294@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343344c4-7a12-4e58-84b9-6b8a7ef51294@oracle.com>

On Wed, Mar 20, 2024 at 06:01:14PM +0530, Anand Jain wrote:
> On 3/19/24 22:25, Josef Bacik wrote:
> > For some of our tests we have
> > 
> > _require_btrfs_fs_feature raid56
> > 
> > to make sure the raid56 support is loaded in the kernel.  However this
> > isn't the only limiting factor, we can have only zoned devices which we
> > already check for, but we could also have BTRFS_PROFILE_CONFIGS set
> > without raid5 or raid6 as an option.  Fix this by simply checking the
> > profile as appropriate and skip running the test if we're missing raid5
> > or raid6 in our profile settings.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   common/btrfs | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/btrfs b/common/btrfs
> > index b0f7f095..d9b01a48 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -111,8 +111,12 @@ _require_btrfs_fs_feature()
> >   		_notrun "Feature $feat not supported by the available btrfs version"
> >   	if [ $feat = "raid56" ]; then
> > -		# Zoned btrfs only supports SINGLE profile
> > -		_require_non_zoned_device "${SCRATCH_DEV}"
> 
> Don't we still need to exclude the zoned device from the
> RAID56 test cases?

_btrfs_get_profile_configs removes RAID5 and RAID6 from the available profiles
if the scratch device is zoned.  Thanks,

Josef
