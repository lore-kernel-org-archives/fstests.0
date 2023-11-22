Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AMXn34xe"
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A31101
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 06:07:17 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5cc69df1b9aso7148197b3.3
        for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700662037; x=1701266837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8++4lViNma3RJHOIDGYVy8A20Z60l8vKvG63SA/z04k=;
        b=AMXn34xeGbdt27u5qPWx7MEZuBektce0fSlaX+PtjqDafs9eguqALTV+GVdG9ksek0
         6VFdQsjXolZkfIrcXgEjPrjJUU9gitnqsbJaLn6XkXmomerysW58DpJubBHULcvaMQUm
         PHqwoop3Aehjw1oMa9wnEQyhOUUENc5Jltmpjx1p5lI5nCAK/jj+4ivolvdzJSFxoqra
         jMXs5Xb1IIWvbFH1Jf3y7kRjtSzDnddjwduiPdjnTnKSE2/90LB9HeGC93lOA3jwOuKY
         K+6y5gS1JBLk4Xc/s8HecDogg5lyulFJWmd3UjJm4FhwwJy55AUtrInOOFsQ5gVmPtm5
         FzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662037; x=1701266837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8++4lViNma3RJHOIDGYVy8A20Z60l8vKvG63SA/z04k=;
        b=oa0xhUQcWPG4y+0eo/O69xueR7HLhSL4EajtjbWWakOBWQ7OjNA1CwINJfoKiF3ge6
         HgoKAcYwhX1afqWktTv5xeyLuPO9ObyZ6Um6LrNsuThgsCl+gIDUtJNdp1LO2/XJFf9a
         6SiadWhlQF0isfueoAAbsZcQk/8x6uh0wOKkD2Qcmhx5DbFYnmCnmYrzIRsk5kRtMEXN
         cShNFX27QnlLoEc6eZxgXzkcra9h+gAhNd58q8n5UPOewtHopywBFGYe+gK6x31QaeCo
         +vmSr48ucyAbN2MSP+W5vHbOfIxNldbGnJ10wy846YSxBZDKwshWOFkqtVWGN4cZLu9o
         rAdA==
X-Gm-Message-State: AOJu0YxHT+msQcJhSbTn5Q7lU6i/nqrENFq0upk6DTpKHzPg6UvIxONf
	OVpHPljWAFwopd2VJQCcp9Vhzz5bMuLCBgqj83woo0HS
X-Google-Smtp-Source: AGHT+IG1Y2tl1j2y7t0PxPbcfrAcUD4ydsMVfe1KO1cC4y2RxUyxU8BbPYVfghOtc7+3tJn89DS7lQ==
X-Received: by 2002:a0d:ca90:0:b0:5ca:7a21:7e22 with SMTP id m138-20020a0dca90000000b005ca7a217e22mr2544381ywd.9.1700662036744;
        Wed, 22 Nov 2023 06:07:16 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u3-20020a81cf03000000b005cb7fccffe2sm1173392ywi.126.2023.11.22.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:07:16 -0800 (PST)
Date: Wed, 22 Nov 2023 09:07:15 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] tests/btrfs: add tests to the remount group
Message-ID: <20231122140715.GC1733890@perftesting>
References: <a8732c1d8994cced3560d4e35fd82c1b0ec4968d.1700643177.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8732c1d8994cced3560d4e35fd82c1b0ec4968d.1700643177.git.anand.jain@oracle.com>

On Wed, Nov 22, 2023 at 04:55:44PM +0800, Anand Jain wrote:
> Several test cases under tests/btrfs are missing from the remount
> group. This patch adds the test cases that use -o remount to the remount
> group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
