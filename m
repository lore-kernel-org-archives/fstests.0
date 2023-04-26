Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E16C77B7E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 19:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjDZTlL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjDZTlL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 15:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20949273E
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682538027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=svlsnVt9lJtfNrEwb6LF9Y2V1kuByKT0qBd+mt5PCFE=;
        b=AFgSESsT1YBY5beeiJGoHpSVrPX4qa/b1AFEXugEf1vyf5/dxFwMaQ434l6ExzkPSUZDWn
        YwrKl8W0hA6ZzT1wb5slJMSt37K3bn5lWZ/nLh24PG+psOiKHhwuW3AylESjJDGI7CVrVe
        mut6ysG7kpdhxqyfcEuRfcBnp/xxMAs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--s8y_nrqPAmArWPH1386rA-1; Wed, 26 Apr 2023 15:40:25 -0400
X-MC-Unique: -s8y_nrqPAmArWPH1386rA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-63b81520de5so8554564b3a.0
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 12:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538024; x=1685130024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svlsnVt9lJtfNrEwb6LF9Y2V1kuByKT0qBd+mt5PCFE=;
        b=VGEpu3v/o+G5mimCpOTm5/nXpGwlr5fKpzYpFVkhbijTRH4Td5MG52pjKg7mBxl5Fq
         Oxj93hrNLCjDQ2oWTTJcnSCzcrZ/J3djU+M6Jl7t4t+5PrXRr//KrQLCF7g1KMt9Nsuk
         QInGeMsGAUg8F88U4tsA4OP+RDBwSQqie/pVpaZYcrYoKNIE/kpHWWVtn30UG+GX64C4
         8mVRy1VLgibnLx3mWlkIpSpTrMG5w1qGbuhQoDkqyQQuUr/o4zlY1DTB5OoB+uG36zsA
         ei29z1723TfytUhYUTXBqXo8rc0yiLd+LY2nLvggiRYnyTVz2NF/xYBxqlQC3ZrZR1dV
         XQFA==
X-Gm-Message-State: AAQBX9dyb3VVQ+xEntPvt10VLLbE/n1sBWrJMy5FQuMDvbZazYOmjlkm
        u3+8P5kUkMwGmPo1oz0dIgGbeDdwjDJxVAMyut6bwCwfeYYP/ImrLQXelfCrZhk+M24kootDDMZ
        n7+fo9UscmfOs0WbA3A==
X-Received: by 2002:a05:6a00:c8a:b0:626:cc72:51ac with SMTP id a10-20020a056a000c8a00b00626cc7251acmr30066762pfv.30.1682538024530;
        Wed, 26 Apr 2023 12:40:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlAIUBES0z3W4MoSAi1nh4ECYvL5Srzv7WegrXwVmnkQLjWeJr18SGJx4Jwv+vkdsl9Vn75w==
X-Received: by 2002:a05:6a00:c8a:b0:626:cc72:51ac with SMTP id a10-20020a056a000c8a00b00626cc7251acmr30066742pfv.30.1682538024185;
        Wed, 26 Apr 2023 12:40:24 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000a0a00b0062d8e79ea22sm11519219pfh.40.2023.04.26.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 12:40:23 -0700 (PDT)
Date:   Thu, 27 Apr 2023 03:40:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 1/6] Add AFS support
Message-ID: <20230426194018.hrq3pme5wkxia5pm@zlang-mailbox>
References: <20230426143011.lktpz46bytvub6kh@zlang-mailbox>
 <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-2-dhowells@redhat.com>
 <868873.1682524402@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868873.1682524402@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 26, 2023 at 04:53:22PM +0100, David Howells wrote:
> Zorro Lang <zlang@redhat.com> wrote:
> 
> > 
> > I nearly forget we have this file :-D
> > 
> > If you'd like to update some docs about AFS testing, you can check
> > README and README.config-sections.
> 
> I'll have a look at that.
> 
> > So I hope to double check with you if the mount source must be started with
> > "%" ?
> 
> or "#", yes.  Have a look here:
> 
> 	http://docs.openafs.org/AdminGuide/HDRWQ208.html#HDRWQ211
> 
> The in-kernel afs fs takes a string in afs mountpoint format as its source.

So do we need to change the below line:

  echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1

to

  echo "$SCRATCH_DEV" | grep -q ^[%#] 

?

> 
> David
> 

