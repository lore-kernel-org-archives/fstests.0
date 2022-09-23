Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544BCECAAD8
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Sep 2022 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIWFFD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Sep 2022 01:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIWFFC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2022 01:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E1261DA7
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 22:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663909499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gYkBmkGLZYuLNvVkAEgaPACwbFnPLrreizkLX7uzDY=;
        b=T6Rn0MEjYHJ2TmOqnHlh6XDIEr+1glOeqDVfxGzRodIpx/Go0l+ePqzVyTE2jeTVWeZvkh
        XwQg4L4ZadWanNlHcOO/+k1gqt7Bpb+UaNpbdi7Thq8MT9Az6NI+QRrKqgek0vKUKth5KV
        MizfJJD2YFiH/DoSiV5ow7sabFFdG70=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-xrJAK8E6MX6wYHSLy2NNZw-1; Fri, 23 Sep 2022 01:04:57 -0400
X-MC-Unique: xrJAK8E6MX6wYHSLy2NNZw-1
Received: by mail-pg1-f200.google.com with SMTP id i22-20020a63e456000000b0043c096be700so2553837pgk.1
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 22:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+gYkBmkGLZYuLNvVkAEgaPACwbFnPLrreizkLX7uzDY=;
        b=DDvzJ/VTi+Z+zgLTQeHS1li9Y+zgZ+9CLbnQBByv8LLnHN9hIja5MmhPCYoY5ZiRaq
         WehAsxcsXeTtIRvZc8qpgfq+YoGn5ECgV7Atb9u7rFYJHVaQamOIRFdsxQp2VclWAnus
         pawvJFB2ur2KbDGV7jdTYAjERF1TIG6sOloPD62n2r6L1zeWWNZL0FOjLK3Nk7PCkeRX
         XxfJU8aQfeuXqmlr/tArZyZ6jmd/pnwK4TPwMY9FECxCfG8xNHZArRC0E8QJ19f88faA
         EFA0OurOavW+NC58XeTO4x34GIPVj5sdlMgCAECS8omTaeV1//Y27nmBvbD2E31ADFKt
         nR1Q==
X-Gm-Message-State: ACrzQf1uVUlgyWhntc3LLAiSc8LCn2QH3oq1LCkySG91rUx5z778dxSM
        z7RfR4TZpC1+qqCNIbvZUSTBGa+ug/aU1TRSKyNsi2A5atIT+aXapsgxmBbubZ/dXjvuSfj0uR4
        a2Me8d8TbYRhz6jqZ7Q==
X-Received: by 2002:a17:90a:c02:b0:1fb:b69d:140f with SMTP id 2-20020a17090a0c0200b001fbb69d140fmr7385427pjs.139.1663909496866;
        Thu, 22 Sep 2022 22:04:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ETscUHPIEqIggRG+RBRFSZuNGE+e5aI3AbKdreFLx1duEtVYx352jUjeSL62nEQmzGaYHrQ==
X-Received: by 2002:a17:90a:c02:b0:1fb:b69d:140f with SMTP id 2-20020a17090a0c0200b001fbb69d140fmr7385409pjs.139.1663909496588;
        Thu, 22 Sep 2022 22:04:56 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001709b9d292esm4867491plb.268.2022.09.22.22.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 22:04:56 -0700 (PDT)
Date:   Fri, 23 Sep 2022 13:04:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] common: Fix file leak in _get_max_file_size
Message-ID: <20220923050452.uuvsydbqlcbiphuo@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
 <Yy0oizGOSvd6Z2Yu@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy0oizGOSvd6Z2Yu@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 08:31:23PM -0700, Eric Biggers wrote:
> On Thu, Sep 22, 2022 at 03:48:19PM +0200, Pavel Reichl wrote:
> > This is obviously mostly problematic for FS lacking support for sparse
> > files.
> > 
> > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > ---
> >  common/rc         | 1 +
> >  tests/generic/692 | 0
> >  2 files changed, 1 insertion(+)
> >  mode change 100644 => 100755 tests/generic/692
> > 
> > diff --git a/common/rc b/common/rc
> > index 228fcb37..c9078649 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4637,6 +4637,7 @@ _get_max_file_size()
> >  			l=$m
> >  		fi
> >  	done
> > +	rm -f $testfile
> >  	echo $l
> >  }
> 
> Removing the file is fine, but I didn't have filesystems that lack support for
> sparse files in mind when I wrote this function.  Maybe it should look at $FSTYP
> first, and only use the generic algorithm as a fallback for unhandled types?

That might be good idea. The current algorithm takes too long time for fs which
doesn't support sparse file.

Anyway, this $testfile should be removed. If Pavel would like to change this
function likes:

_get_max_file_size()
{
	case $FSTYP:
	exfat)
		# calculate the max file size of exfat according to blocksize, then
		echo $max_file_size_of_exfat
		;;
	# Add ext* if extN forks think it's better
	*)
		# By default, do the algorithm this function does originally
		;;
	esac
}

he can split this part as a separated patch, then let's review it. Or we can
have this patch at first, then let Eric change it when he'd like to do that.

Thanks,
Zorro

> 
> - Eric
> 

