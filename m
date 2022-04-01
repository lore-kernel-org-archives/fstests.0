Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC8DC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Apr 2022 05:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiDAFcp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Apr 2022 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiDAFco (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Apr 2022 01:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0487E3A1B5
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648791054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QMXqtrbsC5xFcoJnlfW2A3rDBF4OPWrvizGei7+JWY=;
        b=bNf7X4fcwMNpU2yu9CugHDOFE9FF6Qj5Xpzk8SQub8FKWub2c45w2bd2oPji0b7Qr9OYg/
        g+Kpe3WC5xglPrruxjRJMZ6vo8mD5RUECOUK3JVkjqWZ1tKMLoXQK04K4F9TZbA+ztSJ+u
        7+AYcojIojUyfuodIHHggXYPrhsPjQA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-NbC7Y-dQOOWPLF8NDcb1Kw-1; Fri, 01 Apr 2022 01:30:53 -0400
X-MC-Unique: NbC7Y-dQOOWPLF8NDcb1Kw-1
Received: by mail-pf1-f200.google.com with SMTP id y27-20020aa79afb000000b004fa7883f756so984104pfp.18
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 22:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7QMXqtrbsC5xFcoJnlfW2A3rDBF4OPWrvizGei7+JWY=;
        b=TI88XkddmakAVPGg0n56b+k3pYw8k8J4ieudtCWbvZ6aG/sfrfiGe118h/U3cFw5iu
         +ykB5jDRP5P0K0HIZ+s/B2+sKsx8G+4ZkIKZ2ey42WVQwVDZmyWSZX30mqbQErsc13V9
         UGuMzdtcZ/OIjWQDJqXo4/RZnpIK2pWolKdhPVYIJFiwUz4YXr5lnQgCJn4znJ6Kjj6L
         gJFpjHIiuAgjlWJU2o6CWUz4Nj1SUZmNr0ycH4+7dBn2pwbsr3J5E9jRdRI4wjCXXrro
         x5ZTqP2HE2Os9Hc3Cxp8WyodxH0zvdg61Z62gPTCOiNNo2cX1t4RaV7buFQVe3bJ13Q5
         vWvA==
X-Gm-Message-State: AOAM531uvUrzqnlHuGLUsahVKQBzvTpgiRQzE+jbwGiCuLJkUDNJMOpZ
        BATTzSPSrYnJz+o2QqVgHmMksJgD4zy/iq5ePHaZJcRMwVB7J6CmsUfdXb4b+HdEV+y1WJaAAC0
        uGOWgKlfSFZVPy/JH2w==
X-Received: by 2002:a17:902:684e:b0:154:3b94:e30c with SMTP id f14-20020a170902684e00b001543b94e30cmr8829439pln.89.1648791052561;
        Thu, 31 Mar 2022 22:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY7OvK2M1A5AqbXUDoQ2crpDG+2Q85cwgkdCc0FQgN2u2i+IfXl3sL6nrto7SfNk04ngqIng==
X-Received: by 2002:a17:902:684e:b0:154:3b94:e30c with SMTP id f14-20020a170902684e00b001543b94e30cmr8829414pln.89.1648791052218;
        Thu, 31 Mar 2022 22:30:52 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm1056282pgc.80.2022.03.31.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 22:30:51 -0700 (PDT)
Date:   Fri, 1 Apr 2022 13:30:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
 <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 10:23:35PM +0530, Ritesh Harjani wrote:
> On 22/03/31 09:49PM, Ritesh Harjani wrote:
> > On 22/03/31 10:59PM, Zorro Lang wrote:
> > > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > > Hello,
> > >
> > > Hi,
> > >
> > > Your below patches looks like not pure text format, they might contain
> > > binary character or some special characers, looks like the "^M" [1].
> 
> Sorry to bother you. But here is what I tried.
> 1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
>    the patches.
> 2. Saved the patch using mutt. Again didn't see such character while doing
> 	cat -A /patch/to/patch
> 3. Downloaded the mail using eml format from webmail. Here I do see this
>    character appended. But that happens not just for my patch, but for all
>    other patches too.
> 
> So could this be related to the way you are downloading these patches.
> Please let me know, if I need to resend these patches again? Because, I don't
> see this behavior at my end. But I would happy to correct it, if that's not the
> case.

Hmm... weird, When I tried to open your patch emails, my mutt show me:

  [-- application/octet-stream is unsupported (use 'v' to view this part) --]

Then I have to input 'v' to see the patch content. I'm not sure what's wrong,
this's the 2nd time I hit this "octet-stream is unsupported" issue yesterday.

Hi Darrick, or any other forks, can you open above 4 patches normally? If that's
only my personal issue, I'll check my side.

Thanks,
Zorro

> 
> -ritesh
> 

