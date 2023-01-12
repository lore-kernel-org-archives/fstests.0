Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE9C61DB3
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 21:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbjALVAx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 16:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbjALU6x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 15:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FB3E847
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 12:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673556143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enxs5t1rHQj7Aw3iLl4HikhjvPXRzTAMi5QJIIWTxBQ=;
        b=emJJOm+VO4xMsOAtP64HkysONsT7HMtLa3tFAJINShB8N9ZWqQnBxaNDxMyBKCAeqCoPO5
        6gHWWB6HADlLyoeaWMXIqLNgIXxGOuXLFtw2hN1m4TNSYaab2Soxpdf88xcPjfSN6fSIRI
        q6+PCcWDbAFV3UOauWFbEnOz65qbhr8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-khN3wYRSP92Gu_1A6gJHPQ-1; Thu, 12 Jan 2023 15:42:20 -0500
X-MC-Unique: khN3wYRSP92Gu_1A6gJHPQ-1
Received: by mail-pf1-f200.google.com with SMTP id ay33-20020a056a00302100b00586ad46edf9so7598083pfb.20
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 12:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enxs5t1rHQj7Aw3iLl4HikhjvPXRzTAMi5QJIIWTxBQ=;
        b=EK8o902mwGS9G9f/7A7EyFaDYxTR8fs5s2uvaelzEDxrPJ8C3vFiszM5/Z8QNV6Qcq
         wTItCPmAJzajiu4I1WGLCk/64mAEMtob2Jq4isn6YsgUWvNgZJBZQWHEffIppKECEn4W
         lVb3RTc8fcWwNHBq1mqIvtdIl+nX2jxzCL1Fv94whqPd4ZGp0YrIHL1vwdnI3/SrTiaH
         rhNbvbtKxKb2YLDwWKc7lKk3FqRkozLZXwhbehWC3suxVfdkSO7AAPqLGfk0VL8/rJlx
         dQKRp1TD173quN3Yoz+Zw5iN+eI7eMqKeFRsDbbO078DNs08GAMIwsFHYpccNUJYIoP/
         nXSQ==
X-Gm-Message-State: AFqh2kodbmnru8sfalzEtjKZA7UJNjfWDM6RprWMxi/pfwWGS47427kw
        JzBXZyBb8VbklIimKfTyjbkk6pei3cvX1wlg4hrOtZKmFyqyBLO1WExkd9k3esLhYAdl1o+oWUB
        SFDm5qvqfu/ex++DeFQ==
X-Received: by 2002:aa7:808a:0:b0:588:441:d0d3 with SMTP id v10-20020aa7808a000000b005880441d0d3mr14838364pff.23.1673556138649;
        Thu, 12 Jan 2023 12:42:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuRRHJv1ujU/UIIbuUeCg74whbz4B5fN7GRDJecupAORSo3VnTaS7r92b1g9Qq1pwmpkKvITg==
X-Received: by 2002:aa7:808a:0:b0:588:441:d0d3 with SMTP id v10-20020aa7808a000000b005880441d0d3mr14838340pff.23.1673556138099;
        Thu, 12 Jan 2023 12:42:18 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7950b000000b00581013fcbe1sm12282630pfp.159.2023.01.12.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:42:17 -0800 (PST)
Date:   Fri, 13 Jan 2023 04:42:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     David Disseldorp <ddiss@suse.de>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] more python dependence. was: populate: fix horrible
 performance due to excessive forking
Message-ID: <20230112204213.k6amqgcydn76pjsm@zlang-mailbox>
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-2-david@fromorbit.com>
 <Y75Q/dBXOIeIPonK@magnolia>
 <Y79pOYhJICghtLgj@magnolia>
 <20230112112458.4b024930@echidna.fritz.box>
 <Y8A+bGITjQo1p3rg@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8A+bGITjQo1p3rg@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 12, 2023 at 09:07:56AM -0800, Darrick J. Wong wrote:
> On Thu, Jan 12, 2023 at 11:24:58AM +0100, David Disseldorp wrote:
> > Hi Darrick,
> > 
> > On Wed, 11 Jan 2023 17:58:17 -0800, Darrick J. Wong wrote:
> > 
> > > > (removexattr looks like a pain in perl though...)
> > > > 
> > > > Anyway it's late now, I'll look at the diff tomorrow.  
> > > 
> > > ...or thursday now, since I decided to reply to the online fsck design
> > > doc review comments, which took most of the workday.  I managed to bang
> > > out a python script (perl doesn't support setxattr!) that cut the xattr
> > > overhead down to nearly zero.
> > 
> > IIUC we currently only depend on python for the fio perf tests and
> > btrfs/154 . My preference would be to not see it spread further
> 
> I don't appreciate your dismissal of the patch before I've even posted
> it!
> 
> The fstests README clearly lists python3 as a dependency.  Argument
> parsing and xattr calls are provided by the base python3 runtime.  No
> third party libraries are required for this new program, and if they
> were, they'd be added to the README.

Sorry Darrick, that README description might not exact enough :/ some packages
are not *necessary* for the whole fstests running. Their missing might just
cause some single cases be skipped.

The python3 isn't necessary running/building dependence of fstests. Some
people might run fstests without python3 currently. And I don't plan to
make it become *necessary* (no running if no python3) now. If you'd like
to add python3 dependence to common helpers, that might affect more cases.

So how about fall back to old code if no python3? Or you'd like to skipped
populate related testing if no python3? Or use another way to reduce the
hard dependence change.

Thanks,
Zorro

> 
> > (especially if it's just to shave off a little runtime), mostly because
> > it's a pain for dependency tracking.
> > Perhaps you could use perl's syscall(SYS_fsetxattr(), ...)? Well, that or
> 
> Raw system calls are a terrible idea for maintainability.  You'd
> *seriously* rather I open-code the glibc xattr wrappers and make the
> fstests community maintain that for the sake of your preference?
> 
> > rewrite it again in awk ;-P
> 
> WTAF?
> 
> --D
> 
> > Cheers, David
> 

