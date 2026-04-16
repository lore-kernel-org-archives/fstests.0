Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE426D4E5
	for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357872; cv=none; b=J4huOL4HyYLWvdhqCwIYC3tcI80Vg0W40L3SaOuhXoXOiH1WSNIbWQBP7qhzFvu939gLExQTRyBwN+JvBHzFnrsMhRgEyE2dfOP7XVHDLAe2OZVvoKVaH4WL8K4BOUQKjnAw/mFqFVGQ2d2FyBAj5CO10OZO4D5uNrq9uinyhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357872; c=relaxed/simple;
	bh=HwTULR+ArmpS34DWNxL3XEYLjNLV9h6hO0jvsnmqFo0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HikLXNctM6UXKQYWW/Ne/xg+YcUZShebnAMlu2WcE1oZjhTJ1a22tX8d5u/epCUogWC8OiHGeXfCgQYL1p+cFj4y3KLDgCJznyS/lfNNkVXIXOFLh8zJk4lnh9G/2Qh0N3tv/Mtekd+38HW6nD6ia0DiRj0xdovxWv60e4dy0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5WVGuFY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5WVGuFY"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so7115735a91.2
        for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357871; x=1776962671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LJ8LfPaSbQ6lDGslM73KZc6YjmQtWm3xrl4bEFZYHU=;
        b=a5WVGuFYQuzRPxXAvipiXEAiji9ah/hVPvglEx+SaRUDvgKVRyHplNDhc+5SWlCXaa
         +Q1BQn05iW1ZIjpR8DkLYR809hZeyf47fKC9KW+3Vty8Xslwn3cXC4b41iOD9JcDRrmS
         Jnc6+O8BxeqBY9JVGNqkW5Vi4Uc5lzpNhIR2cGmY5hCaXOZLPJr6I6BgH/Zm4ASLVukN
         PYzfHBvF4RxKKUQKPBjKm8IqdnqDnOHenRj8BDgl3yji15A5IA2S8z3vyohbWUxlF/5o
         BQMz4u+YRDjjdpD/LtGjFgDo1jstbAFeqmrpMqKDxbe8sQkXuE4dxzDwEvahnG8e9pfu
         VaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357871; x=1776962671;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LJ8LfPaSbQ6lDGslM73KZc6YjmQtWm3xrl4bEFZYHU=;
        b=l0t+hEQRvqM4ZRkeBkn8rwo/HsAzi6TtrOwlcI7w1PXumUDfsk+Ns70YZtmcdl8+yN
         VHvqr0WodDCQbZo56bNigx2cZxlZzftQ1C7WXxOWGS9ueD5cv6+jIkry7Ixmwo5y++P5
         /x+pFFluWeELebXlT36SOMriaIZhvderLj1o0Vze9BJJdq7lVF3OX+6BFvjILA5UynfY
         SrmlGleElnsEQAE1Xo/I7+hxcDKkJkv3sorvrpkFlVH3xSrE9DNwB2wA8f5C3OCzGfh8
         j80gmX/wkVTs+/hBTl26rM+mPQPeb/qr1WCNq0X7GTwi1FtGhQSA9vyyMcDc+FjJXkB1
         SNmQ==
X-Gm-Message-State: AOJu0YwUf1s0IlJNiUWEMDr96n794D8MWxX0xy2U6M+Is94ngoVzzgLB
	N6ZkGSrqCp6b0MF5RTIxf+zpJkRSnI4Zouhk1hCkf8UOTYMC1w1o5NbR
X-Gm-Gg: AeBDievPGoOjD5XCerMP1LsFh529TEAlgjQKzXJru06buy0TvfqakqCYEX6RKKIZln8
	sfVNb2pkPmBT1Tlynqz6MSeV9z1Kylt6szqv995NbY+JWJy7MBxV1+AgzJnUv4p8t9flQqWoLts
	f9p6UugcdvDWomO30jT8MlINWQZZDEIF0v37okVjvHoLgoVpip953mln+NMZVJwJDAWC02QIT7Z
	WZCAl8LhyNIp0wXNvPSgdyYtelCwLygL8gFb/lRXO4OScay3oZeRNY5adaxQMOQlL4SuqHpuMUL
	JjLMjUzcMkGFpnTHBTA4DnZwbRGtHj5+Ul06ude8Vnf7FbnLgu7qz3dPIVkXIH6gxUat/vb4ZCh
	Ww4oY4NH7dzkSn1Qltjvg9WqmTmE4BZNcYbS4f9J7AOwRe4/EA+hkOgSgEqNrRT2d3fR/JRDxtT
	El40RJYbkh4XnkbSeljWgL
X-Received: by 2002:a17:903:2290:b0:2b4:59d4:9a with SMTP id d9443c01a7336-2b459d403abmr204096045ad.2.1776357870507;
        Thu, 16 Apr 2026 09:44:30 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478109ab5sm60192625ad.19.2026.04.16.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:44:30 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 00:44:20 +0800
To: Jan Prusakowski <jprusakowski@google.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	anand.jain@oracle.com, wqu@suse.com
Subject: Re: [PATCH] generic/050: handle f2fs as nojournal filesystem
Message-ID: <aeERuvIUU91WKrz_@zlang-mailbox>
Mail-Followup-To: Jan Prusakowski <jprusakowski@google.com>, 
	fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, anand.jain@oracle.com, 
	wqu@suse.com
References: <20260410131821.991005-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410131821.991005-1-jprusakowski@google.com>

On Fri, Apr 10, 2026 at 01:18:20PM +0000, Jan Prusakowski wrote:
> F2FS uses a checkpoint mechanism for metadata consistency rather than a
> traditional journal. Roll-forward recovery is only needed if there are
> fsync'd files since the last checkpoint.
> 
> In this test case, files are created without fsync, so there is no
> roll-forward data to replay during mount.
> 
> Therefore, F2FS does not need to write to the device to recover, and
> successfully mounts on the read-only block device. Thus, it should be
> treated as nojournal in this case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> ---
>  tests/generic/050 | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tests/generic/050 b/tests/generic/050
> index 3bc37175..3a641a65 100755
> --- a/tests/generic/050
> +++ b/tests/generic/050
> @@ -46,6 +46,18 @@ elif [ "$FSTYP" = "btrfs" ]; then
>  	# So for this test case, btrfs will not get any dirty log tree thus
>  	# it can be treated as "nojournal".
>  	features="nojournal"
> +elif [ "$FSTYP" = "f2fs" ]; then
> +	# F2FS uses a checkpoint mechanism for metadata consistency rather than a
> +	# traditional journal. Roll-forward recovery is only needed if there are
> +	# fsync'd files since the last checkpoint.
> +	#
> +	# In this test case, files are created without fsync, so there is no
> +	# roll-forward data to replay during mount.
> +	#
> +	# Therefore, F2FS does not need to write to the device to recover, and
> +	# successfully mounts on the read-only block device. Thus, it should be
> +	# treated as "nojournal" in this case.
> +	features="nojournal"

OK, so f2fs is similar with what btrfs does in this case.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  fi
>  _link_out_file "$features"
>  
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
> 
