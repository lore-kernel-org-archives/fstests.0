Received: from mail-wr0-f174.google.com ([209.85.128.174]:35884 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbdHQJeA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Aug 2017 05:34:00 -0400
Received: by mail-wr0-f174.google.com with SMTP id x43so38745997wrb.3
        for <fstests@vger.kernel.org>; Thu, 17 Aug 2017 02:34:00 -0700 (PDT)
Date: Thu, 17 Aug 2017 11:33:56 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170817093356.kzhubdouourvhki3@hades.localdomain>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
 <20170816070214.GJ14807@eguan.usersys.redhat.com>
 <20170817085232.fup4bcyy4eaoufh5@hades.localdomain>
 <20170817091947.GV14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817091947.GV14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> > 
> > May I ask what's the 'official' purpose of auto group? I agree of adding it to
> > fuzzers, but 'auto' group sounds to me like a group of tests being run by
> > default, which wouldn't be a good idea in this case.
> 
> I found one email I sent before that explained the auto group
> definition, I copied & pasted it here:
> 
> "
> I searched for Dave's explainations on 'auto' group in his reviews, and
> got the following definitions:
> 
> - it should be a valid & reliable test (it's finished and have
>   deterministic output) [1]
> - it passes on current upstream kernels, if it fails, it's likely to be
>   resolved in forseeable future [2]
> - it should take no longer than 5 minutes to finish [3]
> 
> [1] http://www.spinics.net/lists/fstests/msg00938.html
> [2] http://www.spinics.net/lists/fstests/msg01548.html
> [3] http://www.spinics.net/lists/fstests/msg01719.html
> "
> 
> So I think it's a good 'auto' test :)
> 

Sounds fair :) thanks I don't remember to have seen it before

> Thanks,
> Eryu

-- 
Carlos
