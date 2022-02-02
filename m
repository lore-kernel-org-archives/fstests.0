Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3473C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Feb 2022 13:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiBBNsj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Feb 2022 08:48:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55916 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344439AbiBBNsh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Feb 2022 08:48:37 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 212DmP9O032506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Feb 2022 08:48:26 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 578D015C0040; Wed,  2 Feb 2022 08:48:25 -0500 (EST)
Date:   Wed, 2 Feb 2022 08:48:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] common: handle old versions of modprobe which don't
 support --help
Message-ID: <YfqLqRKWlCSUP31i@mit.edu>
References: <20220201231936.981003-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201231936.981003-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 01, 2022 at 06:19:36PM -0500, Theodore Ts'o wrote:
> There exists versions of modprobe out there which are so old that
> modprobe --help isn't a thing.  They're certainly not going to support
> modprobe --remove-patiently, so test to make sure modprobe --help
> works to suppress a spurious warning.

I was going to reword the last part of the commit message, but forgot
to do it before sending out the message.

- works to suppress a spurious warning.
+ works to avoid causing all tests to fail due to the error message
+ to stderr showing up in $seq.out.

	     	    	       	  - Ted
