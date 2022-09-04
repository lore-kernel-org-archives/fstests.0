Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFAFECAAD4
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Sep 2022 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiIDNQI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Sep 2022 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiIDNQH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Sep 2022 09:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C5303DA
        for <fstests@vger.kernel.org>; Sun,  4 Sep 2022 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662297361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJ5kx5GSVqmDyMggaz6MuQ7w9VCEp5UcT1diD2YpI2E=;
        b=Ys1U3C0qIARPCbuB3kxtwd/T40I9la/bS/knJEN1bZGijw5ftXeuPt3UCtxBmktrZhmNwG
        fx+hwloLPAbQiI+sOZgOHuHDxZ6QL6mkadMFF5eCv2eVLEEJoBNzVptV4vYGMxVf83KvZp
        /PiaeuQLh+VW9K0y/A9lpl61G/00yOo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-kX9ssEpXOHOuT1ZC7Ee8LQ-1; Sun, 04 Sep 2022 09:16:00 -0400
X-MC-Unique: kX9ssEpXOHOuT1ZC7Ee8LQ-1
Received: by mail-qt1-f198.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so5182796qtb.10
        for <fstests@vger.kernel.org>; Sun, 04 Sep 2022 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yJ5kx5GSVqmDyMggaz6MuQ7w9VCEp5UcT1diD2YpI2E=;
        b=Zk0IazT239KXXCtQKcmOUM51iHWwbnnfey1SLnnzugm0MAdtg3yXhnlZlKqAG/ionl
         csytSaNG95twRCe2GKUoj0kJxIiEUn/ehgWlx2Ak85Tlk3/mU3YHJhnhloB8Pk19Rkla
         8k54eZdGvVrRUuRlFzID3piQBK9wjw/krMDnNV9z53HlvHeS/sWa/f/m7tMQbiO69iCw
         yvbS85qnxAav9hCyfriLK3n0fseuu3JPJ+QGCSftHf/5Dwf0lmjVh73+KaRQodmR9bqv
         JvwyrDgRP90y2nZNi5e0K0+Yq+5q/iOHDe1vjTR3/p1UnKUH+4wH9pnQTmzVSCNDF7RI
         Cd+w==
X-Gm-Message-State: ACgBeo3HJO0iNRAU89mmtWp3V8s2ftN7iQxGrkzuFDAdjbDlDYNt7ng1
        ndBysbU2aagtFtGsEv0i2Xe98xvPPwi4V+YPui/qaHfGtLUsgyrVBAoEb1Ol9XG/1GGRzm9k7Lj
        08UqX4j2Ebwh5cQC+87ALuO0FMIFxkcd4uN+vVnDFcvnpLyw0T/T4374WOYGK3HJSFw==
X-Received: by 2002:a05:622a:95:b0:343:66b1:d32a with SMTP id o21-20020a05622a009500b0034366b1d32amr35221194qtw.32.1662297359362;
        Sun, 04 Sep 2022 06:15:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73D/KejJPoRZVOG1bs+e3JWf8wwl21iYdMBPVw1L5/bD73hUocaF4XSUQctjWKIEzxEUeHDA==
X-Received: by 2002:a05:622a:95:b0:343:66b1:d32a with SMTP id o21-20020a05622a009500b0034366b1d32amr35221169qtw.32.1662297359104;
        Sun, 04 Sep 2022 06:15:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l2-20020ac87242000000b0034455ff76ddsm4941002qtp.34.2022.09.04.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 06:15:58 -0700 (PDT)
Date:   Sun, 4 Sep 2022 21:15:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        djwong@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: generic/650 makes v6.0-rc client unusable
Message-ID: <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> While investigating some of the other issues that have been
> reported lately, I've found that my v6.0-rc3 NFS/TCP client
> goes off the rails often (but not always) during generic/650.
> 
> This is the test that runs a workload while offlining and
> onlining CPUs. My test client has 12 physical cores.
> 
> The test appears to start normally, but then after a bit
> the NFS server workload drops to zero and the NFS mount
> disappears. I can't run programs (sudo, for example) on
> the client. Can't log in, even on the console. The console
> has a constant stream of "can't rotate log: Input/Output
> error" type messages.
> 
> I haven't looked further into this yet. Actually I'm not
> quite sure where to start looking.
> 
> I recently switched this client from a local /home to an
> NFS-mounted one, and that's where the xfstests are built
> and run from, fwiw.

If most of users complain generic/650, I'd like to exclude g/650 from the
"auto" default run group. Any more points?

Thanks,
Zorro

> 
> 
> --
> Chuck Lever
> 
> 
> 

