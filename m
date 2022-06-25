Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7222C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiFYSbt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiFYSbs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 14:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 175E7140BC
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656181907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nngqE5G13z98vhicyvNq2lHOXVumiC0a6jx6eWbmyu8=;
        b=NDZwgyejOcn7jg5VhWnYj9fDfZGkg4i1vdohUwGukOG2QBwwlu3JvzM/lI1LT9cQq7a0nB
        PwVfuCVeFDoOYLMrEJyuePGgI3AggHB6+47wlVHd7b6byUGvuMdws2VihegLUraGiIPIga
        JLKECyq/POgb1jsyEJ3pXCyGg2vfpsQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-yH6aQSALNh-yN-bg4V13wA-1; Sat, 25 Jun 2022 14:31:45 -0400
X-MC-Unique: yH6aQSALNh-yN-bg4V13wA-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso5622082qvb.15
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 11:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nngqE5G13z98vhicyvNq2lHOXVumiC0a6jx6eWbmyu8=;
        b=40lbXWnrve6rzsBiUEn8BltsxUzc3Crz99Z4G06F1y647z10rfOonREd5Qjoqmw9fb
         G06yq7BLJ69HLvTL6XvzH6Xq7/MI8Qq0amSvWGV/ln/MqkdNeQAHXDYcxCYBqcpve7uc
         uuzOPfJIKMigFfPuuru1Go4NNhk2mYxkMhxebpWym7ld3SQzUQfwveS00UD8d2W3KSLR
         3r2XVS6UQ/FdxbuMnLW2nzD5x3gjR/wRo717XxwNf7gzHpzubOWHDFdtIikp7SBuWGNR
         ESaBzT7C1sasej+X7MvD3eWXdzmr2znaDemMcXqR9GeopJ+/5/ZrvwjqN2e7JEIGAmNm
         TUVQ==
X-Gm-Message-State: AJIora9sZDJU/cjwRj7tXM+TR1qaVkWP0o+CAGMWHm9GgjiIyDkzHRY9
        s2ByARMGvgO/lSkKOxDH+k7mR981huNPsbu3hcnQYEzUWWnw+txdT1sQO3icuCsL54544k3FUxx
        9R8NJLRphljltI9Qg7A==
X-Received: by 2002:a05:622a:64c:b0:318:9fcb:89a6 with SMTP id a12-20020a05622a064c00b003189fcb89a6mr2411924qtb.380.1656181905053;
        Sat, 25 Jun 2022 11:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u91WGSG8zdeKns+upZv3YKNLHAeVAxLoh0XvLp6WUGw7EYLpTh5dxPy1eQIzw/5xpIq79TSg==
X-Received: by 2002:a05:622a:64c:b0:318:9fcb:89a6 with SMTP id a12-20020a05622a064c00b003189fcb89a6mr2411912qtb.380.1656181904810;
        Sat, 25 Jun 2022 11:31:44 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006a6bb044740sm5161208qkp.66.2022.06.25.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 11:31:44 -0700 (PDT)
Date:   Sun, 26 Jun 2022 02:31:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v3] generic/692: test group ownership change
Message-ID: <20220625183136.kves26fjthhwtzdy@zlang-mailbox>
References: <20220615092826.2333847-1-brauner@kernel.org>
 <20220625151715.vxlq2wflms2ykcju@zlang-mailbox>
 <20220625162540.lhdnqly5xzqzkesm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625162540.lhdnqly5xzqzkesm@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 25, 2022 at 06:25:40PM +0200, Christian Brauner wrote:
> On Sat, Jun 25, 2022 at 11:17:15PM +0800, Zorro Lang wrote:
> > On Wed, Jun 15, 2022 at 11:28:26AM +0200, Christian Brauner wrote:
> > > When group ownership is changed a caller whose fsuid owns the inode can
> > > change the group of the inode to any group they are a member of. When
> > > searching through the caller's groups we failed to use the gid mapped
> > > according to the idmapped mount otherwise we fail to change ownership.
> > > Add a test for this.
> > > 
> > > Cc: Seth Forshee <sforshee@digitalocean.com>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > Cc: <fstests@vger.kernel.org>
> > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > ---
> > > /* v2 */
> > > - Zorro Lang <zlang@redhat.com>:
> > >   - various minor fixes
> > > 
> > > - Christian Brauner (Microsoft) <brauner@kernel.org>:
> > >   - Expand test to also cover overlayfs on top of idmapped mounts.
> > > 
> > > /* v3 */
> > > - Amir Goldstein <amir73il@gmail.com>:
> > >   - Switch from calls to the mount binary to _overlay_mount_dirs helper.
> > > 
> > > - Christian Brauner (Microsoft) <brauner@kernel.org>:
> > >   - Expand test to also cover non-idmapped mounts.
> > > ---
> > 
> > We really make this test case become more complicated than its v1 version,
> > for covering overlayfs on top of idmapped mounts.
> > 
> > I'm wondering if it's worth splitting this case to two cases, one similar
> > as v1 to cover the original regression test, the other expand for overlayfs,
> > although that will cause some duplicate testing steps use?
> 
> Both approaches would work. I chose to combine them because it's the
> same regression just under different circumstances and because it avoids
> duplicated code.
> 
> > 
> > If most of you prefer this v3 version, I'd like to get more review points.
> 
> If you want to wait for additional acks then sure. But I'd like to not
> put merging this off for too long.
> I prefer to merge regression tests quickly so they are run as soon as
> possible especially since the fix is already upstream for about 2 weeks
> now.

I'd like to split this test to two cases for two reasons:
1) Reduce the complexity of this case.
2) That overlayfs test part need a separated overlayfs idmapped feature which
   is not necessary to be a limitation of this regression test, cause this
   case can't be run on older kernel.


And that:
  _supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
line should be called after _scratch_mount, due to $SCRATCH_MNT might not be
mounted before _scratch_mount.

Thanks,
Zorro

> 
> Christian
> 

