Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF3C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 18:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiGUSEd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGUSE2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 14:04:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3708C3FD
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 11:04:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26LI4FZ0022702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 14:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658426657; bh=TCUZJhaV7E2B7bTt98bv6Vd58aWzueYXB6CRve5LAnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OIZSXoKP9LzTz+SNP6O0GCxvRSCFtkyN6WvRUpLLbTsfvfX7M/j9siUBITedt3qHd
         PfOIi78twbH2/5tQc5rrueohuYCMw3CIyYn9Iei6x5zWRFm3o1L7zn0lU2lwrDWc2l
         vjG+JyfnfNwGR/zpZtS8RiL1mOS6ATBVakcyJDPbS4fFCxnm8A+7sJa6/OH0w3Wr1M
         49k62KAeVuvvXHd6XzwVHZ9bTmZnIW08B4+uou0/IPr0pifNA9cD13YlRy3W763OnX
         tsmzR+fZKfqY2E5K7xKb2E6iF/+LLyRa6Zx1BTnqTIM/VOztwJ450JUD3XS1K8XPJ5
         lKwWxRJz7i22w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6ECB615C3EBF; Thu, 21 Jul 2022 14:04:15 -0400 (EDT)
Date:   Thu, 21 Jul 2022 14:04:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Boyang Xue <bxue@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <YtmVH8HNHHxVUyoM@mit.edu>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu>
 <YtlcwZ/66pJhpdiS@mit.edu>
 <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
 <6C27EF62-B619-4451-9CBC-B21CEC72F66D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C27EF62-B619-4451-9CBC-B21CEC72F66D@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 03:14:30PM +0000, Chuck Lever III wrote:
> > - Loopback means there's often no way to know which part of
> > the stack (client or server) is the problem.
> 
> And by the way, it's even worse if that single system acts as
> both the NFS server scratch device and the server under test.
>

I believe Boyang has stated that this has been seen both in loopback
and in an externally mounted configuration.

Boyang, in your external exported configuration, was the lockup
happening on the client or server system?

					- Ted

P.S.  I just don't have the capability of testing NFS on separate VM's
for the client and server using gce-xfstests.  It's on my list of
things to implement someday, but I just don't have time at the moment.
Maybe a GSOC project someday...  Or if someone has time, patches or
pull requests to https://github.com/tytso/xfstests-bld are gratefully
accepted.  :-)
