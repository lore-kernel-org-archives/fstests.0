Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EEAEB64D9
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Jul 2023 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGDOYU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDOYT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Jul 2023 10:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141AE47
        for <fstests@vger.kernel.org>; Tue,  4 Jul 2023 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688480616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=57AtHpZhcPpEHLsInIfUqM25aW9rcqFnYP6msW9agQ0=;
        b=OdkbNRNDSCRJbUHqufvfXrkzZV6eYI770RqnqIXtjiUqhhH9g3vtU1tU1tM2J1GqMyHxz2
        e9s4elg+SN5Et5JvsH/KAKZDqOkf6fku9sz1Yiaw+BawDyyADIopMlVmn2WZQMJ9boYb49
        UaQTHz4vXon/17NJ9EcHvM4sONcGFTQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-BzmK6uiSOaSVn1sLtC2GvA-1; Tue, 04 Jul 2023 10:23:34 -0400
X-MC-Unique: BzmK6uiSOaSVn1sLtC2GvA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7940ffbfc8fso868322241.0
        for <fstests@vger.kernel.org>; Tue, 04 Jul 2023 07:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480614; x=1691072614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57AtHpZhcPpEHLsInIfUqM25aW9rcqFnYP6msW9agQ0=;
        b=WibrsbH2KAwEvF1coLcK+OFNDauYeskH9FqKVxKq9NSBuLZ6ZhDh7WvQXWnuFgm7JG
         0ZA37MACl3jTnmC5K9h6xqB9RTEmoTSiqqvdZoAicdFCYN5cmf6qexT8Vb+JafqqfLZT
         9PKpEM3VLQ5ns+pEubbquTFopcHVeHMw8pzU5xGiuWeowfUUko8/PDXvEcZSj5/barbV
         gCJWpfRFybfH6+HBzgBw68zDz1i+gGqy7ZtskEyINPVQwyl3QOb6E+9vfMl9u4g1vyW2
         8120sFowNJSLmZcPWgH0PhOFV/F4cQx3N7uKC7/Rah+SRI2YzZAUfBAt3tBZ8qE/j8YF
         49sw==
X-Gm-Message-State: ABy/qLasd3LZZTjAzDTriAYEAQj+QPaO24cX2QvBGB91Yy8VQRllvXXj
        GGOvjVk1Y8NxWcco2uownDo+o5o+3SiFnn8QUaVln1TzpLGWeFU4Nr7tQII/YVVqLiB4CLQGAFl
        uLutUzIp8k+rzcb61
X-Received: by 2002:a67:fc19:0:b0:443:5927:d41b with SMTP id o25-20020a67fc19000000b004435927d41bmr6292385vsq.31.1688480614158;
        Tue, 04 Jul 2023 07:23:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFi7K6KdJZH2Fogg+A4zdTj9t10jEJx5femfLaZvfwZ3GO87oJ8A4Oinbz+v+OGm1najWGnMA==
X-Received: by 2002:a67:fc19:0:b0:443:5927:d41b with SMTP id o25-20020a67fc19000000b004435927d41bmr6292376vsq.31.1688480613925;
        Tue, 04 Jul 2023 07:23:33 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id z26-20020ac83e1a000000b003f7a54fa72fsm1496655qtf.0.2023.07.04.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:23:33 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:23:30 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 5/5] xfs: test growfs of the realtime device
Message-ID: <20230704142330.7svxnzrdgdys2x5x@aalbersh.remote.csb>
References: <168840381298.1317961.1436890061506567407.stgit@frogsfrogsfrogs>
 <168840384128.1317961.1554188648447496379.stgit@frogsfrogsfrogs>
 <20230704140357.tg2yxfknkzniotve@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704140357.tg2yxfknkzniotve@aalbersh.remote.csb>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

oh those are from 041, haven't noticed

-- 
- Andrey

