Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02717CDB482
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Oct 2023 05:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJSFvl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Oct 2023 01:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjJSFvf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Oct 2023 01:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73AB6
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 22:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697694645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rlLF5HCj0fr5QN1awIaaxu3jBU7j2Cl7M4uQMSHbd4w=;
        b=CtRYLncMQkv+Wtuoss7Iqe+9dnCDAQWTmbLDcx6WIC927Nu3lC+AhzoqCnzxL/lj/xKBHQ
        nZU26LJhVwIV085kTP7IQ/vNK7nUFJZxpUe2/FD5rMMuQR+etZBYThuMVKl0mpoS7liZAo
        mUGqssyWVrxvQC+09zjizbJ9SJZZrPg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-8NT5RfFKNWiTHfYpx8Gbyw-1; Thu, 19 Oct 2023 01:50:43 -0400
X-MC-Unique: 8NT5RfFKNWiTHfYpx8Gbyw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27cfa6f943fso5402228a91.2
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 22:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694642; x=1698299442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlLF5HCj0fr5QN1awIaaxu3jBU7j2Cl7M4uQMSHbd4w=;
        b=g/+rYDim94DaJ1njEgGBb+/OnJO6MqExvjHMzLHNqLiDdQ2oKi4b/KKAVFL/eS894C
         DL+7vCiSWCYssxci19SjS6fLj5NwXzsu+JvXynL1PV+MLs5lcGmTE8MNDUNXYuNvwVtM
         v8d6X+m+QBXz5B52QjNnourYnr4rWqFK31eR1lguAnK8mgs2ykXX7Rrm0A9ADD3Fp5uy
         Ek8+6jURIkToV/509Dm8yzokhkfg72insuLteeOgR7Ee5LhLcLVpTiiyEYGV4VlcFL+R
         8nrY6bNsmJcj2ObiyJAc5JY19FhrxPMYBiq7k1eQE+LptKhr5O9XTYgsPFfM10f6t44s
         HEbg==
X-Gm-Message-State: AOJu0Yy2Tzc8wyG16Z7wl4LJP+AVgJ1Sn4ckWPjtPCbl6Vv5skHWr6q5
        feVxZddElauRP2Sd2Lobyz9E6tDJzRDcL4g0afPDpsZ4NmujqaHUIsTxciPMkjLUhxk6MZaPdHd
        YhmI1/Xp3JfhX68E/Fr90gkLlx6s/G8E=
X-Received: by 2002:a17:90a:195e:b0:27d:3968:8366 with SMTP id 30-20020a17090a195e00b0027d39688366mr1229761pjh.8.1697694642022;
        Wed, 18 Oct 2023 22:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJScbiTMBW8Z1c8mYRklAIaDRYlDLvOcOHxbrgwxtTHkOxzBTTvtK0E9tEjuUAyvGDxJpxrw==
X-Received: by 2002:a17:90a:195e:b0:27d:3968:8366 with SMTP id 30-20020a17090a195e00b0027d39688366mr1229752pjh.8.1697694641683;
        Wed, 18 Oct 2023 22:50:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gc21-20020a17090b311500b0027d0de51454sm837665pjb.19.2023.10.18.22.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:50:41 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:50:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/707: Test moving directory while being grown
Message-ID: <20231019055038.bb5njpat2tz3nwer@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230131125416.16120-1-jack@suse.cz>
 <20230131142544.dwlk7kwdpznatlt3@zlang-mailbox>
 <20231012140903.tuwphwhp7fh7podq@quack3>
 <20231018141237.oorwr6f5vd54vybc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231018185530.77phjvdwafrjkdoe@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018185530.77phjvdwafrjkdoe@quack3>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 18, 2023 at 08:55:30PM +0200, Jan Kara wrote:
> On Wed 18-10-23 22:12:37, Zorro Lang wrote:
> > On Thu, Oct 12, 2023 at 04:09:03PM +0200, Jan Kara wrote:
> > > On Tue 31-01-23 22:25:44, Zorro Lang wrote:
> > > > On Tue, Jan 31, 2023 at 01:54:16PM +0100, Jan Kara wrote:
> > > > > Test how the filesystem can handle moving a directory to a different
> > > > > directory (so that parent pointer gets updated) while it is grown. Ext4
> > > > > and UDF had a bug where if the directory got converted to a different
> > > > > type due to growth while rename is running, the filesystem got
> > > > > corrupted.
> > > > > 
> > > > > Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > 
> > > > Thanks, this version looks good to me,
> > > > 
> > > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > > 
> > > Guys, I have just noticed this patch didn't get merged. Can you please pick
> > > it up? Thanks!
> > 
> > Hi Jan, I think it has been in fstests v2023.02.05 release, as:
> > 
> > commit da69ce70dfcdbd88d6f940d7c1ab346d5a1e5f82
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Tue Jan 31 13:54:16 2023 +0100
> > 
> >     generic/707: Test moving directory while being grown
> > 
> > Isn't it same with this patch? Please check, and feel free to tell me
> > if anything wrong.
> 
> Bah, sorry. Not sure why I didn't find it when grepping :-|. I'm sorry for
> the noise.

No problem, Feel free to ping me if any of your patches get missed :)

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

